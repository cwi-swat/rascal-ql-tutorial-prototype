module Plugin

import Load;
import Parse;
import Resolve;
import Check;
import Outline;
import Compile;

import ParseTree;
import util::IDE;
import Message;
import IO;

private str TQL ="Tutorial QL";

anno rel[loc,loc, str] Tree@hyperlinks;

rel[loc,loc,str] computeXRef(Info i) 
  = { <u, d, "<l>"> | u <- i.refs.use, d <- i.refs.use[u], 
                      l <- i.labels, d in i.labels[l] }; 

public void setupQL() {
  registerLanguage(TQL, "tql", Tree(str src, loc l) {
    return parseQL(src, l);
  });
  
  
  contribs = {
    outliner(node(Tree pt) {
      return outline(implodeQL(pt));
    }),
    
    annotator(Tree(Tree pt) {
      ast = implodeQL(pt);
      inf = resolve(ast);
      msgs = checkForm(ast, inf);
      return pt[@messages=msgs][@hyperlinks=computeXRef(inf)];
    }),
    
    builder(set[Message] (Tree pt) {
      ast = implodeQL(pt);
      msgs = checkForm(ast, resolve(ast));
      if (msgs == {}) {
        js = pt@\loc[extension="js"];
        writeFile(js, form2js(ast));
        html = pt@\loc[extension="html"];
        writeFile(html, form2html(ast, js));
      }
      return msgs;
    })
  };
  
  registerContributions(TQL, contribs);
}



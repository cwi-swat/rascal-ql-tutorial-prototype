module Plugin

import Load;
import Parse;
import Resolve;
import Check;
import Outline;
import Compile;
import Normalize;
import Exercises;
import AST;

import ParseTree;
import util::IDE;
import util::Prompt;
import Message;
import IO;

private str TQL ="Tutorial QL";

anno rel[loc,loc, str] Tree@hyperlinks;

rel[loc,loc,str] computeXRef(Info i) 
  = { <u, d, "<l>"> | <u, d> <- i.refs.use, <l, d> <- i.labels }; 

public void main() {
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
        qs = normalize(desugar(ast));
        js = pt@\loc[extension="js"];
        writeFile(js, questions2js(ast.name, qs));
        html = pt@\loc[extension="html"];
        writeFile(html, form2html(ast.name, js));
      }
      return msgs;
    }),
    
    popup(
      menu("Tutorial QL", [
        edit("Rename...", str (Tree pt, loc selection) {
          ast = implodeQL(pt);
          refs = resolve(ast).refs;
          names = { u | u <- refs.use<0> + refs.use<1>, selection <= u };
          if ({loc name} := names) {
            new = prompt("Enter a new name: ");
            return rename(unparse(pt),  name, new, refs);
          }
          alert("No name selected");
          return unparse(pt);
        })]))
    
  };
  
  registerContributions(TQL, contribs);
}



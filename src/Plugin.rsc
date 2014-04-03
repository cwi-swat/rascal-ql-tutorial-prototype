module Plugin

import Load;
import Parse;
import Resolve;
import Check;
import Outline;
import Compile;
import Normalize;
import exercises::Part1;
import exercises::Part2;
import AST;

import ParseTree;
import util::IDE;
import util::Prompt;
import Message;
import IO;

private str TQL ="Tutorial QL";

anno rel[loc, loc] Tree@hyperlinks;

public void main(list[value] args) {
  registerLanguage(TQL, "tql", Tree(str src, loc l) {
    return parseQL(src, l);
  });
  
  
  contribs = {
    outliner(node(Tree pt) {
      return outline(implodeQL(pt));
    }),
    
    annotator(Tree(Tree pt) {
      ast = implodeQL(pt);
      ref = resolve(ast);
      msgs = checkForm(ast, ref);
      return pt[@messages=msgs][@hyperlinks=ref];
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
          refs = resolve(ast);
          names = { u | u <- refs<0> + refs<1>, selection <= u };
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



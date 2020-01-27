module Plugin

import Load;
import Parse;
import Resolve;
import Check;
import Outline;
import Compile;
import Normalize;
import Visualize;
import Format;
import Dependencies;
import exercises::Part1;
import exercises::Part2;
import exercises::Part3;
import AST;

import ParseTree;
import util::IDE;
import util::Prompt;
import Message;
import IO;

private str TQL ="Tutorial QL";

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
      ref = resolve(ast);
      msgs = check(ast, ref) + cyclicErrors(controlDeps(ast) + dataDeps(ast));
      return pt[@messages=msgs][@hyperlinks=ref];
    }),
    
    builder(set[Message] (Tree pt) {
      ast = implodeQL(pt);
      msgs = check(ast) + cyclicErrors(controlDeps(ast) + dataDeps(ast));
      if (msgs == {}) {
        js = pt@\loc.top[extension="js"];
        writeFile(js, compile(desugar(ast)));
        html = pt@\loc.top[extension="html"];
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
             return rename(unparse(pt), name, new, refs);
           }
           alert("No name selected");
           return unparse(pt);
          }),
        action("Visualize", void (Tree pt, loc selection) {
          ast = implodeQL(pt);
          visualize(resolve(controlDeps(ast) + dataDeps(ast)));
        }),
        
        edit("Format", str (Tree pt, loc selection) {
          return format(implodeQL(pt));
        })]))
    
  };
  
  registerContributions(TQL, contribs);
}



module exercises::Snippets

import IO;

/*
 * First, past the following imports in the console;
 */
 
import exercises::ImportThis;
import util::ValueUI;

/*
 * Paste statements from below into the console,
 * and see what happens or call the function directly
 * to get a preview of the QL implements
 */
 
void snippets() {
  // Parse a TQL file in the examples directory
  ast = loadExample("tax.tql");
  
  // Explore the AST in a browser
  tree(ast);
  
  // Explore the AST in a textual editor
  text(ast);
  
  // Pretty print it
  println(format(ast));
  
  // Perform name resolution (click on the locations to jump to names) 
  resolve(ast);
  
  // Type check a questionnaire (click on locations to jump to editor)
  msgs = check(ast);
  
  // Normalize the questionnaire
  norm = normalize(ast);
  
  // Format the normalized version to see what happened
  println(format(norm));
  
  // Compile a form
  println(compile(ast));
  
  // Extract control dependencies
  deps = controlDeps(ast);
  
  // Visualize control dependencies
  visualize(deps);
}
 
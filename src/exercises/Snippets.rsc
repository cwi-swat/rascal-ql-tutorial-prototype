module exercises::Snippets

import IO;

/*
 * First, past the following import in the console;
 */
 
import exercises::ImportThis;

/*
 * Paste statements from below into the console,
 * and see what happens.
 */
 
void snippets() {
  // Parse a TQL file in the examples directory
  ast = loadExample("tax.tql");
  
  // Pretty print it
  println(format(ast));
  
  // Perform name resolution (click on the locations to jump to names) 
  refs = resolve(ast);
  
  // Type check a questionnaire
  check(ast);
  
  // Normalize the questionnaire
  norm = normalize(ast);
  
  // Format the normalized version to see what happened
  println(format(norm));
  
  // Compile a form
  println(compile(ast));
  
  // Visualize data dependencies
  visualize(dataDeps(ast));
}
 
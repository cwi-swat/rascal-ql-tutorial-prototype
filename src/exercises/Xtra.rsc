module exercises::Xtra

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;


/*
 * Exercise 7 (analysis): identify use-before-defined questions
 * Generate the locations of defined questions used in computed questions
 * before they are textually defined. 
 * 
 * Example, for:
 *   "q1" q1: int = 2 * q2
 *   "q2" q2: int
 * generate the location of q2
 *
 * - observe that dataDeps is a relation from definition to use
 *   and that Refs.use is a relation from use to definition.
 * - use the Refs.use relation (returned by resolve) to find
 *   definition locs for a use
 * - determine syntactic ordering by comparing the .offset field of locs
 * 
 * Tip: use relation composition (o) on dataDeps and use to get
 * a relation from definition to definition.
 * 
 * Optional: hook the analysis up to the type checker to produce a warning
 * if a question's variable is used before it is defined.
 */
 
 set[loc] usedBeforeDefined(Form f) {
   return {};
 }

 /* Exercise 8 (transformation): transform a form so that no dependency
  * ordering constraints are violated by textual occurrence.
  *
  * Example:
  *   "q1" q1: int = 2 * q2
  *   "q2" q2: int
  * Should be transformed to:
  *   "q2" q2: int
  *   "q1" q1: int = 2 * q2
  * 
  */

Form reorder(Form f) {
  return f;
}  
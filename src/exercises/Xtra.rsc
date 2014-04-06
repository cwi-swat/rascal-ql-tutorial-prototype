module exercises::Xtra

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;
import analysis::graphs::Graph;

/*
 * Exercise 6 (analysis): identify use-before-defined questions
 * Generate the locations of defined questions used in computed questions
 * before they are textually defined. 
 * 
 * Example, for:
 *   "q1" q1: int = 2 * q2
 *   "q2" q2: int
 * generate the location of q2
 *
 * - use the resolved relation of Exercise 5 to find the
 *   the order required by the dependencies (use the order()
 *   function analysis::graphs::Graph to compute topological order). 
 * - determine textual ordering by comparing the .offset field of locs
 * 
 * Optional: hook the analysis up to the type checker to produce a warning
 * if a question's variable is used before it is defined.
 */
 
 set[loc] usedBeforeDefined(Form f) {
   return {};
 }

 /* Exercise 7 (transformation): transform a form so that no dependency
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
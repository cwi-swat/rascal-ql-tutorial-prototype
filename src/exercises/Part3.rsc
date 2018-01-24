module exercises::Part3

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;
import analysis::graphs::Graph;

/* 
 * Exercise 6: Implement a rename refactoring
 * 6a (analysis): compute all locations referencing/referenced by a name loc
 *
 * Warm up:
 * call resolve(loadExample("tax.tql"))
 * click on the locations to see where they point
 * count the number of uses (references) and defs (declarations)
 *   (use size from the standard module Set)
 *
 * This exercise amounts to computing the locations of all names that
 * refer to the same entity (question). This includes both declaration
 * occurrences and use occurrences. This amounts to computing
 * the equivalence relation of the Names relation returned by resolve.
 * (See http://en.wikipedia.org/wiki/Equivalence_relation)
 *
 * - obtain the names relation by calling resolve on an AST (Resolve.rsc)
 * - use a comprehension to compute the symmetric closure of a relation
 *   (symmetric closure means <x, y> in the relation if also <y, x>)
 * - use R* to compute the reflexive, transitive closure of a relation
 * - use the "image" R[x] to compute all locs 'equivalent' to `name`.
 */ 

set[loc] eqClass(loc nameOccurrence, rel[loc use, loc def] names) {
  return {};
}

/*
 * Exercise 6: Implement a rename refactoring
 * 6b (transformation): substitute all names in the input source
 *
 * Construct a renaming map map[loc, str] based on the result of 6a
 * use the function substitute(src, map[loc, str]) from the String 
 * module. Observe the effect of rename by selecting an identifier
 * in a TQL editor, and richt-click, select Rename... in the
 * context menu.
 *
 * Optional: check as precondition that `newName` isn't
 * already used. Retrieve the name at a location by 
 * subscripting on src: src[l.offset..l.offset+l.length].
 *
 * Optional: implement the rename refactoring, but now on ASTs.
 * Use format (Format to see the result of your refactoring.)
 * Why is this approach problematic for implementing refactorings?
 */
str rename(str src, loc toBeRenamed, str newName, rel[loc use, loc def] use) {
  return src;
}

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
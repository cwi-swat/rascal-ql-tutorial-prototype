module Exercises

import AST;
import Resolve;
import IO;
import List;
import String;

/*
 * Exercise 1: add an unless statement which is to be used
 * similar to ifThen statements: unless (x > 1) { "Q?" q: int }
 *
 * - add a production to Question in QL.rsc
 * - add a constructor to Question in AST.rsc
 * - add a tc rule to the type checker in Check.rsc
 * - add a case in the outliner in Outline.rsc
 *
 * Tip: implement unless analogous to ifThen in all cases
 *
 * Check in the IDE that the type checkers indeed signals
 * errors in unless conditions and bodies, and that its
 * conditions appear in the outliner.  
 *
 * Optional: change the typechecker so that a warning
 * is issued in the case of ifThen(not(_), ...).
 */


/*
 * Exercise 2: desugar unless to ifThen
 *
 * - use `visit` to traverse and rewrite the Form
 * - use pattern matching to match on unless nodes.
 * - rewrite unless nodes to ifThen using =>
 *
 * The desugar function is called before compilation
 * so the compiler (Compile) does not have to be changed
 * to support unless.
 *
 * Optional: add unless else, and desugar it to ifThenElse
 */
Form desugar(Form f) {
  return f;
}

/* 
 * Exercise: support for date time fields
 *
 * - add syntax to QType to allow date fields (QL)
 * - add new QType constructor for dates (AST)
 * - add new case to type2widget in Compile to generate 
 *   DateValueWidgets (see resources/js/framework/value-widgets.js)
 *
 */

/* 
 * Exercise 3: Implementing a rename refactoring
 * 3a: compute all locations referencing/referenced by a name loc
 *
 * This exercise amounts to computing an equivalence class over the use-def
 * relation `use` which is declared as `rel[loc use, loc def]`.
 *
 * - use a comprehension to compute the symmetric closure of a relation
 * - use R+ to compute the transitive closure of a relation
 * - use right image R[x] to compute all locs equivalent to `name`.
 */ 

set[loc] eqClass(loc name, Use use) {
  return {};
}

/*
 * Exercise 3: Implement a rename refactoring
 * 3b: substitute all names in the input source
 *
 * - construct a renaming map map[loc, str] based on 3a
 * - use the function substitute(src, map[loc, str]) from String
 *
 * Optional: check as precondition that `new` name isn't
 * already used. Retrieve the name at a location by 
 * subscripting on src: src[l.offset..l.offset+l.length].
 */
str rename(str src, loc name, str new, Refs r) {
  return src;
}
 
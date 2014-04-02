module Exercises

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;

/*
 * Exercise 0: FizzBuzz (see http://c2.com/cgi/wiki?FizzBuzzTest)
 *
 * "Write a program that prints the numbers from 1 to 100. 
 * But for multiples of three print “Fizz” instead of the 
 * number and for the multiples of five print “Buzz”. For 
 * numbers which are multiples of both three and five print
 * “FizzBuzz”."
 *
 * Tip: [1..101] gives the list [1,2,3,...,100]
 * Tip: use println from IO to print.
 */
 
void fizzBuzz() {

}

/*
 * Exercise 1 (extension): add an unless statement which is to be used
 * similar to ifThen statements: unless (x > 1) { "Q?" q: int }
 *
 * - add a production to Question in QL.rsc
 * - add a constructor to Question in AST.rsc
 * - add a tc rule to the type checker in Check.rsc
 * - add a case in the outliner in Outline.rsc
 * - add a normalize rule to the normalize in Normalize.rsc
 *   (note: desugar unless to if(not(e), s))
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
 * Exercise 2 (extension): add support for date valued questions
 *
 * - add syntax to QType to allow date fields (QL.rsc)
 * - add new QType constructor for dates (AST.rsc)
 * - add new case to type2widget in Compile to generate 
 *   DateValueWidgets (see resources/js/framework/value-widgets.js)
 *
 */
 
 

/*
 * Exercise 3 (transformation): explicit desugaring of unless to ifThen
 *
 * - use `visit` to traverse and rewrite the Form
 * - use pattern matching to match on unless nodes.
 * - rewrite unless nodes to ifThen using =>
 *
 * The desugar function is called before compilation
 * so the compiler (Compile) does not have to be changed
 * to support unless, even if no normalize() was used.
 *
 * Optional: add unless else, and desugar it to ifThenElse
 */

Form desugar(Form f) {
  return f;
}

/*
 * Exercise 4 (analysis): extract control dependencies.
 *
 * - use the Node and Deps data types and nodeFor function shown below
 * - visit the form, and when encountering ifThen/ifThenElse
 * - record an edge (tuple) between each Id used in the condition
 *   and each Id defined in the body/bodies.
 *
 * For inspiration, a function to extract data dependencies
 * is shown below.
 * Tip: first define a helper function set[Id] definedIn(Question q).
 *
 */
 

alias Node = tuple[loc id, str label];
alias Deps = rel[Node from, Node to];

Node nodeFor(Id x) = <x@location, x.name>;

Deps dataDeps(Form f) 
  = { <nodeFor(x), nodeFor(y)> | /computed(_, x, _, e) := f, /Id y := e };

Deps controlDeps(Form f) {
  return {};
}

/*
 * Exercise 5 (analysis): cycle detection
 *
 * - detect cycles in a form using dataDeps and controlDeps
 * - use transitive reflexive closure R* 
 *
 * Optional: compute the Nodes involved in a cycle (if any).
 */

bool hasCycles(Form f) {
  return false;
}

/* 
 * Exercise 6: Implementing a rename refactoring
 * 6a (analysis): compute all locations referencing/referenced by a name loc
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
 * Exercise 6: Implement a rename refactoring
 * 6b (transformation): substitute all names in the input source
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
 
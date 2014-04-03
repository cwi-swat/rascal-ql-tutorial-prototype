module exercises::Part1

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;

/*
 * Exercise 0 (warm-up): FizzBuzz 
 * (see http://c2.com/cgi/wiki?FizzBuzzTest)
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
 * Exercise 1 (evolution): add an unless statement which is to be used
 * similar to ifThen statements: 
 *  unless (x > 1) { "What is your age?" age: int }
 *
 * - add a production to Question in QL.rsc
 * - add a constructor to Question in AST.rsc
 * - add a tc rule to the type checker in Check.rsc
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
 *
 * Optional: fix the outliner (Outline) so that unless conditions 
 * appears in the outline
 * 
 */

/* 
 * Exercise 2 (evolution): add support for date valued questions
 *
 * - add syntax to QType to allow date fields (Lexical.rsc)
 * - add new QType constructor for date types (AST.rsc)
 * - add new case to type2widget in Compile to generate 
 *   DateValueWidgets (see resources/js/framework/value-widgets.js)
 *
 */
 
/*
 * Exercise 3 (evolution): add a conditional expression x ? y : z
 *  
 *  - add production to Expr (QL.rsc)
 *    (Make sure it's low in the priority hierarchy
 *     i.e. x && y ? a : b  is equal to (x && y) ? a : b.) 
 *  - add new Expr constructor in AST.rsc
 *  - add new case to typeOf in TypeOf.rsc
 *  - add new case to tc in CheckExpr.rsc
 *  - add new case to expr2js in Expr2JS.rsc
 */

 

/*
 * Exercise 3 (transformation): explicit desugaring of unless to ifThen
 *
 * Warm up: use visit to
 *  - print out all labels in a form
 *  - count all questions (question/computed)
 *
 * Desugar:
 * - use `visit` to traverse and rewrite the Form
 * - use pattern matching to match on unless nodes.
 * - rewrite unless nodes to ifThen using =>
 *
 * The desugar function is called before compilation
 * so the compiler (Compile) does not have to be changed
 * to support unless, even if no normalize() was used.
 *
 * Optional: add unless-else, and desugar it to ifThenElse
 */

Form desugar(Form f) {
}


/* 
 * Exercise 4: Implement a rename refactoring
 * 4a (analysis): compute all locations referencing/referenced by a name loc
 *
 * Warm up:
 * - call resolve(loadExample("tax.tql")) and extract the Use component from
 *   the result (Refs).
 * - click on the locations to see where they point
 * - count the number of uses (references) and defs (declarations)
 *   (use size from the standard module Set)
 *
 * This exercise amounts to computing the equivalence relation of the use-def
 * relation `Ref.use` which is declared as `rel[loc use, loc def]`.
 * (See http://en.wikipedia.org/wiki/Equivalence_relation)
 *
 * - get the use relation from Refs, returned from resolve (Resolve.rsc)
 * - use a comprehension to compute the symmetric closure of a relation
 *   (symmetric closure means <x, y> in the relation if also <y, x>)
 * - use R* to compute the reflexive, transitive closure of a relation
 * - use the "image" R[x] to compute all locs equivalent to `name`.
 */ 

set[loc] eqClass(loc name, rel[loc use, loc def] use) {
  return {};
}

/*
 * Exercise 4: Implement a rename refactoring
 * 4b (transformation): substitute all names in the input source
 *
 * - construct a renaming map map[loc, str] based on the result of 4a
 * - use the function substitute(src, map[loc, str]) from String
 * - observe the effect of rename by selecting an identifier
 *   in a TQL editor, and richt-click, select Rename... in the
 *   context menu.
 *
 * Optional: implement the rename refactoring, but now on ASTs.
 * Use format (Format to see the result of your refactoring.)
 * 
 * Optional: check as precondition that `newName` isn't
 * already used. Retrieve the name at a location by 
 * subscripting on src: src[l.offset..l.offset+l.length].
 */
str rename(str src, loc toBeRenamed, str newName, rel[loc use, loc def] use) {
  return src;
}
 
 
 /*
 * Exercise 5 (analysis): extract control dependencies.
 *
 * Warm up:
 * - use deep matching (using /) to find a variables in a form
 * - use deep match to find all question with label value (within 
 *   the quotes) equal to name; make sure there such labels in
 *   your test code.
 *
 * Exercise:
 *
 * - use the Node and Deps data types and nodeFor function shown below
 * - visit the form, and when encountering ifThen/ifThenElse
 * - record an edge (tuple) between each Id used in the condition
 *   and each Id defined in the body/bodies.
 * - use deep match (/p) to find Ids in expressions
 *
 * For inspiration, a function to extract data dependencies
 * is shown below.
 *
 * Tip: first define a helper function set[Id] definedIn(Question q)
 * that returns the defined names at arbitrary depth in a question (q).
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
 * Exercise 6 (analysis): cycle detection
 *
 * - detect cycles in a form using dataDeps and controlDeps
 * - first lift a Deps relation to rel[str, str]
 * - use transitive reflexive closure R* 
 *
 * Optional: compute the Nodes involved in a cycle (if any).
 * Optional: produce a set[Message] for such nodes 
 * and hook it up to the type checker (Check.rsc). 
 */

bool hasCycles(Form f) {
  return false;
}


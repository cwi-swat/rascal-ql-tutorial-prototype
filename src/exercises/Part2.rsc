module exercises::Part2

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;

 /*
 * Exercise 5 (analysis): extract control dependencies.
 *
 * Warm up:
 * - use deep matching (using /) to find a variables in a form
 * - use deep match to find all question with label value (within 
 *   the quotes) equal to name; make sure there are such labels in
 *   your test code.
 * 
 * Examples of deep match
 * - freeVars in Compile.rsc
 * - typeEnv in Check.rsc
 *
 * Exercise:
 *
 * - use the Node and Deps data types and nodeFor function shown below
 * - visit the form, and when encountering ifThen/ifThenElse
 *   record an edge (tuple) between each Id used in the condition
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


/* 
 * Exercise 7: Implement a rename refactoring
 * 7a (analysis): compute all locations referencing/referenced by a name loc
 *
 * Warm up:
 * - call resolve(loadExample("tax.tql"))
 * - click on the locations to see where they point
 * - count the number of uses (references) and defs (declarations)
 *   (use size from the standard module Set)
 *
 * This exercise amounts to computing the equivalence relation of the use-def
 * relation `Ref.use` which is declared as `rel[loc use, loc def]`.
 * (See http://en.wikipedia.org/wiki/Equivalence_relation)
 *
 * - obtain the names relation by calling resolve on an AST (Resolve.rsc)
 * - use a comprehension to compute the symmetric closure of a relation
 *   (symmetric closure means <x, y> in the relation if also <y, x>)
 * - use R* to compute the reflexive, transitive closure of a relation
 * - use the "image" R[x] to compute all locs equivalent to `name`.
 */ 

set[loc] eqClass(loc nameOccurrence, rel[loc use, loc def] names) {
  return {};
}

/*
 * Exercise 7: Implement a rename refactoring
 * 7b (transformation): substitute all names in the input source
 *
 * - construct a renaming map map[loc, str] based on the result of 7a
 * - use the function substitute(src, map[loc, str]) from String
 * - observe the effect of rename by selecting an identifier
 *   in a TQL editor, and richt-click, select Rename... in the
 *   context menu.
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

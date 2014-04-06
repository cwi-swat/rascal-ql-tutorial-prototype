module exercises::Part2

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;
import Message;

/*
 * Exercise 4 (transformation): explicit desugaring of unless to ifThen
 *
 * Example of visit:
 *  - Resolve.rsc
 *  - Outline.rsc
 * 
 * Warm up: use visit to
 *  - println out all labels in a form
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
 * Optional: add unlessElse, and desugar it to ifThenElse
 * Optional: write a transformation to simplify algebraic 
 * expressions (e.g.,  1 * x, 0 + x, true && x, false && x).
 */

Form desugar(Form f) {
  return f;
}


 /*
 * Exercise 5 (analysis): construct a data dependency graph.
 *
 * - use the Node and Deps data types and nodeFor function shown below
 * - visit the form, and when encountering a computed question
 *   add edges to the Deps graph to record a data dependency. 
 * - use deep match (/) to find Ids in expressions
 *
 * For inspiration, the function to extract control dependencies
 * is shown below.
 *
 * Tip: use the function visualize(Deps) to visualize the result of your
 * data dependency graph. Click on nodes to see the location they
 * correspond to. 
 *
 */
 

alias Node = tuple[loc location, str label];
alias Deps = rel[Node from, Node to];

Node nodeFor(Id x) = <x@location, x.name>;

Deps controlDeps(Form f) {
  g = {};
  
  set[Node] definedIn(Question q)
    = { nodeFor(d.name) | /Question d := q, d has name };
    
  set[Node] usedIn(Expr e) 
    = { nodeFor(x) | /Id x := e };
  
  Deps depsOf(Expr c, Question q) 
    = {<d, u> | d <- definedIn(q), u <- usedIn(c) };
  
  visit (f) {
    case ifThen(c, q):
      g += depsOf(c, q);
    case IfThenElse(c, q1, q2):
      g += depsOf(c, q1) + depsOf(c, q2);
  }
  
  return g;
}

/*
 * Observe that the Deps graph returned by controlDeps returns a 
 * relation from definitions of questions to uses of variables (question
 *  names). Uses, however, are not connected to their own definitions 
 * in the graph. The resolve function connects them. 
 */

Deps resolve(Deps deps) {
  deps += { <u, d> | d <- deps<0>, u <- deps<1>, d.label == u.label };
  return deps;
}

/*
 * Modify the function below to also show data dependency cycles
 * as errors in the IDE.
 */

set[Message] cyclicErrors(Form f) {
  deps = resolve(controlDeps(f))+;
  return { error("Cyclic dependency", x.location) 
       | <Node x, Node y> <- deps, <y, x> in deps };
}



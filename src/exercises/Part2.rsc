module exercises::Part2

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;
import Message;
import Dependencies;

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
 * A computed question is dependent on the questions it refers 
 * to in its expression. Such dependencies can be represented 
 * as a binary relation (a set of tuples). The goal of this 
 * exercise is to extract such a relation.
 * - use the Node and Deps data types and nodeFor function shown 
 *   in Dependencies.rsc
 * - visit the form, and when encountering a computed question
 *   add edges to the Deps graph to record a data dependency. 
 * - use deep match (/) to find Ids in expressions
 *
 * For inspiration, the function to extract control dependencies
 * is shown Dependencies.rsc.
 *
 * Tip: use the function visualize(Deps) to visualize the result of your
 * data dependency graph. Click on nodes to see the location they
 * correspond to. 
 *
 */
 

/* NB:
 * alias Node = tuple[loc location, str label]; 
 * alias Deps = rel[Node from, Node to];
 */
 
Deps dataDeps(Form f) {
  return {};
}




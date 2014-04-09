module Dependencies

import AST;
import Message;

alias Node = tuple[loc location, str label];
alias Deps = rel[Node from, Node to];

Node nodeFor(Id x) = <x@location, x.name>;

Deps controlDeps(Form f) {

  // Helper functions.
  // The set of alll questions defined withing a single
  // question (e.q. ifThen or, ifThenElse).  
  set[Node] definedIn(Question q)
    = { nodeFor(d.name) | /Question d := q, d has name };
    
  // The set variable occurrences used in an Expr.
  set[Node] usedIn(Expr e) 
    = { nodeFor(x) | /Id x := e };
  
  // Edges between defined questions in the context of q
  // and the expression c.
  Deps depsOf(Expr c, Question q) 
    = {<d, u> | d <- definedIn(q), u <- usedIn(c) };
  
  g = {};
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

set[Message] cyclicErrors(Deps deps) {
  deps = resolve(deps)+;
  return { error("Cyclic dependency", x.location) 
       | <Node x, Node y> <- deps, <y, x> in deps };
}

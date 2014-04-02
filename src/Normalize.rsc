module Normalize

import AST;

/*
 * Normalize a Form to a flat list
 * of ifThen questions, the body of
 * which only contain computed/question
 * elements.
 */

list[Question] normalize(form(_, qs))
  = normalize(group(qs), \true());
 
list[Question] normalize(group(qs), Expr e)
  = ( [] | it + normalize(q, e) | q <- qs );
  
list[Question] normalize(ifThen(c, q), Expr e)
  = normalize(q, and(e, c));

list[Question] normalize(ifThenElse(c, q1, q2), Expr e)
  = normalize(q1, and(e, c))
  + normalize(q2, and(e, not(c)))
  ;
  
default list[Question] normalize(Question q, Expr e)
  = [ifThen(e, q)];

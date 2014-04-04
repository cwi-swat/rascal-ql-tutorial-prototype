module CheckExpr

import AST;
import TypeOf;
import Resolve;

import Message;
import Relation;
import Set;

set[Message] tc(e:var(x), Info i) 
  = {error("Undefined name", e@location) | i.names[x@location] == {} };

set[Message] tc(e:eq(lhs, rhs), Info i)  = checkEq(e, i, lhs, rhs);
set[Message] tc(e:neq(lhs, rhs), Info i) = checkEq(e, i, lhs, rhs);
  
set[Message] tc(n:not(e), Info i)        = tc(n, boolean(), i, e);
set[Message] tc(e:mul(lhs, rhs), Info i) = tc(e, numeric(), i, lhs, rhs);
set[Message] tc(e:div(lhs, rhs), Info i) = tc(e, numeric(), i, lhs, rhs);
set[Message] tc(e:add(lhs, rhs), Info i) = tc(e, numeric(), i, lhs, rhs);
set[Message] tc(e:sub(lhs, rhs), Info i) = tc(e, numeric(), i, lhs, rhs);
set[Message] tc(e:gt(lhs, rhs), Info i)  = tc(e, numeric(), i, lhs, rhs);
set[Message] tc(e:geq(lhs, rhs), Info i) = tc(e, numeric(), i, lhs, rhs);
set[Message] tc(e:lt(lhs, rhs), Info i)  = tc(e, numeric(), i, lhs, rhs);
set[Message] tc(e:leq(lhs, rhs), Info i) = tc(e, numeric(), i, lhs, rhs);
set[Message] tc(e:and(lhs, rhs), Info i) = tc(e, boolean(), i, lhs, rhs);
set[Message] tc(e:or(lhs, rhs), Info i)  = tc(e, boolean(), i, lhs, rhs);

set[Message] tc(Expr::integer(_), Info i) = {};
set[Message] tc(Expr::money(_), Info i) = {};
set[Message] tc(Expr::\true(), Info i) = {};
set[Message] tc(Expr::\false(), Info i) = {};

default set[Message] tc(Expr e, Info i) 
  = {error("Unknown expression construct", e@location)};  

//Helper function to do automatic calling of tc on sub-expressions
// and to prevent type-checking if the sub-expressions have errors.
set[Message] tc(Expr e, QType mgt, Info i, Expr kids...) {
  errs = ( {} | it + tc(k, i) | k <- kids );
  if (errs == {}) {
    return {error("Invalid operand type (expected <type2str(mgt)>)", k@location)
               | k <- kids, !compatible(typeOf(k, i), mgt) };
  }
  return errs;
}

set[Message] checkEq(Expr e, Info i, Expr lhs, Expr rhs) {
  errs = tc(lhs, i) + tc(rhs, i);
  if (errs == {}, !compatible(typeOf(lhs, i), typeOf(rhs, i))) {
    return {error("Incompatible types", e@location)};
  }
  return errs;
}



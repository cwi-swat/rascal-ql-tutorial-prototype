module Check

import AST;
import TypeOf;
import Resolve;
import CheckExpr;
import Message;

Types typeEnv(Form f) 
  = { <q.name@location, q.tipe> | /Question q := f, q has name }; 

set[Message] checkForm(Form f, Names names) = tc(f, <names, typeEnv(f)>); 

set[Message] tc(Form f, Info i) = ( {} | it + tc(q, i) | q <- f.body );

set[Message] tci(Expr c, Info i) 
  = { error("Condition should be boolean", c@location) | typeOf(c, i) != boolean() }
  + tc(c, i);

set[Message] tc(ifThen(c, q), Info i) = tci(c, i) + tc(q, i);

set[Message] tc(ifThenElse(c, q1, q2), Info i) = tci(c, i) + tc(q1, i) + tc(q2, i);

set[Message] tc(Question::group(qs), Info i) = ( {} | it + tc(q, i) |  q <- qs );

set[Message] tc(computed(l, n, _, e), Info i) = tc(e ,i);

default set[Message] tc(Question q, Info _) 
  = {error("Unrecognized question construct.", q@location)};


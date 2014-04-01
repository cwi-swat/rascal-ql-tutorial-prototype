module Check

import AST;
import TypeOf;
import Resolve;
import CheckExpr;
import Message;
import Relation;
import Set;
import IO;

set[Message] checkForm(Form f, Info i) = tc(f, i); 

set[Message] tc(Form f, Info i) = ( {} | it + tc(q, i) | q <- f.body );

set[Message] tci(Expr c, Info i) 
  = { error("Condition should be boolean", c@location) | typeOf(c, i) != boolean() }
  + tc(c, i);

set[Message] tc(ifThen(c, q), Info i) = tci(c, i) + tc(q, i);

set[Message] tc(ifThenElse(c, q1, q2), Info i) = tci(c, i) + tc(q1, i) + tc(q2, i);

set[Message] tc(Question::group(qs), Info i) = ( {} | it + tc(q, i) |  q <- qs );

set[Message] tc(computed(l, n, _, e), Info i) = tcq(l, n, i) + tc(e ,i);

set[Message] tc(question(l, n, _), Info i) = tcq(l, n, i); 

default set[Message] tc(Question _, Info _) = {};

set[Message] tcq(str l, Id n, Info i)
  = { error("Redeclared with different type", n@location) | hasMultipleTypes(n@location, i) }
  + { warning("Duplicate label", n@location) | hasDuplicateLabel(l, i) }
  ;

bool hasMultipleTypes(loc x, Info i) = size(i.refs.def[x]) > 1;

bool hasDuplicateLabel(str l, Info i) = size(i.labels[l]) > 1;


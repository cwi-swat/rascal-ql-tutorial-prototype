module Format

import AST;
import Node;
import FormatExpr;

import lang::box::util::SimpleBox;

str formatForm(Form f) = format(format(f));

/* 
 * Formatting using Box (see lang::box::util::SimpleBox)
 * H: horizontal composition (default spacing hs = 0)
 * V: vertical composition (default spacing vs = 1)
 * I: indented composition (in a V, default vs = 1, indent is = 2)
 */

Box format(form(x, qs))
  = V(H("form", x, "{", hs=1), I([ format(q) | q <- qs ]), "}");

Box format(question(l, x, t))
  = H(l, H(x.name, ":"), getName(t), hs = 1);

Box format(computed(l, x, t, e))
  = H(l, H(x.name, ":"), getName(t), "=", format(e), hs = 1);

Box format(group(qs)) = V("{", I([format(q) | q <- qs]), "}");

Box format(ifThen(e, q)) 
  = H("if", H("(", format(e), ")"), format(q), hs=1);
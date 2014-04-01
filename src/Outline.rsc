module Outline

import AST;
import FormatExpr;
import util::IDE;
import ParseTree;
import Relation;
import List;
import String;
import Node;

str type2str(QType t) = getName(t);

node outline(Form f) {
 rel[str, str, loc] types = {};
 list[node] qs = [];
 list[node] es = [];
 list[node] cs = []; 
 list[node] ls = [];
 
 void addQuestion(Question q) {
   qn = "question"()[@label="<q.name.name>"][@\loc=q@location];
   qs += [qn]; 
   l = "<q.label>"[1..-1];
   ls += ["label"()[@label=l][@\loc=q@location]];
   types += {<type2str(q.tipe), "<q.name.name>", q@location>}; 
 }
 
 void addCond(Expr c) {
   cs += ["cond"()[@label=format(c)][@\loc=c@location]];
 }
 
 top-down visit (f) {
   case q:question(_, _, _): addQuestion(q);
   case q:computed(_, _, _, e): {
     addQuestion(q);
     es += ["expr"()[@label=format(e)][@\loc=e@location]];
   }
   case ifThen(c, _):  addCond(c); 
   case ifThenElse(c, _, _): addCond(c); 
 }

 ts = for (t <- domain(types)) {
   subqs = [ "q"()[@label=qn][@\loc=ql] | <str qn, loc ql> <- types[t] ];
   append "type"(subqs)[@label=capitalize(t)];
 }

 return "outline"(
  "questions"(qs)[@label="Questions (<size(qs)>)"],
  "types"(ts)[@label="Types (<size(ts)>)"],
  "conditions"(cs)[@label="Conditions (<size(cs)>)"],
  "expressions"(es)[@label="Expressions (<size(es)>)"],
  "labels"(ls)[@label="Labels (<size(ls)>)"]
 );
}

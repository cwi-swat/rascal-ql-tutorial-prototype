module AST

data Form
  = form(str name, list[Question] body);
  
data Question
  = question(Label label, Id name, QType tipe)
  | computed(Label label, Id name, QType tipe, Expr expr)
  | ifThen(Expr cond, Question body)
  | ifThenElse(Expr cond, Question body, Question elseBody)
  | group(list[Question] questions)
  ;

data Expr
  = var(Id id)
  | integer(int intValue)
  | string(str strValue)
  | money(real realValue)
  | \true()
  | \false()
  | not(Expr arg)
  | mul(Expr lhs, Expr rhs)
  | div(Expr lhs, Expr rhs)
  | add(Expr lhs, Expr rhs)
  | sub(Expr lhs, Expr rhs)
  | eq(Expr lhs, Expr rhs)
  | neq(Expr lhs, Expr rhs)
  | lt(Expr lhs, Expr rhs)
  | gt(Expr lhs, Expr rhs)
  | leq(Expr lhs, Expr rhs)
  | geq(Expr lhs, Expr rhs)
  | and(Expr lhs, Expr rhs)
  | or(Expr lhs, Expr rhs)
  ;
  
 
data QType
 = boolean()
 | integer()
 | money()
 | string()
 ; 
 
data Id = id(str name);
data Label = label(str label); 

anno loc Form@location;
anno loc Id@location;
anno loc Expr@location;
anno loc Question@location;

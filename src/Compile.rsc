module Compile

import AST;
import Expr2JS;
import Set;
import List;
import String;
import IO;

private loc HTML_TEMPLATE = |project://RascalQLTutorial/resources/qltemplate.html|;

// Assumes normalization
str questions2js(str name, list[Question] qs) =
  "$(document).ready(function () {
  '  var form = new QLrt.FormWidget({ name: \"<name>\", submitCallback: persist});
  '  <for (q <- qs) {>
  '  <question2decl(q, "form")>
  '  <}>
  '  $(\'#QL-content\').append(form.domElement());
  '  form.activate();
  '  function persist(data) {
  '     localStorage[\'QL-persist\'] = JSON.stringify(data);
  '  }
  '});";

str question2decl(qc:ifThen(e, q), str parent) 
  = "var <nameFor(qc)> = <cond2group(e, parent)>;
    '<question2decl(q, nameFor(qc))>";

str question2decl(question(l, v, t), str parent)
  = question2widget(l, v, t, parent, "");

str question2decl(computed(l, v, t, e), str parent)
  = question2widget(l, v, t, parent, exp2lazyValue(e));

str question2widget(str l, Id v, QType t, str parent, str e)
  = "var <v.name> = new QLrt.SimpleFormElementWidget({
    '  name: \"<v.name>\", 
    '  label: <l>,
    '  valueWidget: new QLrt.<type2widget(t)>(<e>) 
    '}).appendTo(<parent>);";

str cond2group(Expr e, str parent)
  = "new QLrt.ConditionalGroupWidget(<exp2lazyValue(e)>).appendTo(<parent>)";
    
str exp2lazyValue(Expr e) 
  = "new QLrt.LazyValue(
    '  function () { return [<ps>]; },
    '  function (<ps>) { return <expr2js(e)>; }
    ')"
  when str ps := expParams(e);
    

private map[Question,int] IDS = ();
private int QID = 0;
str nameFor(Question q) {
  if (q notin IDS) {
    IDS[q] = QID;
    QID += 1;
  }
  return "q$<IDS[q]>";
}

str type2widget(QType::boolean()) = "BooleanValueWidget";
str type2widget(QType::money())   = "MoneyValueWidget";
str type2widget(QType::string())  = "StringValueWidget";
str type2widget(QType::integer()) = "IntegerValueWidget";

list[str] freeVars(Expr e) =  [ x.name | /Id x := e ];

str expParams(Expr e) = intercalate(", ", freeVars(e));

str form2html(str name, loc jsPath) 
  = replaceAll(
       replaceAll(
         replaceAll(tmpl, 
           "__TITLE__", "<name>"),
           "__FORM_JS__", jsPath.file),
           "__ROOT__", "../resources")
  when tmpl := readFile(HTML_TEMPLATE);

  

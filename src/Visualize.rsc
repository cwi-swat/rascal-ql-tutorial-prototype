module Visualize

import vis::Figure;
import vis::Render;
import vis::KeySym;
import util::Editors;

private FProperty FONT = font("Monospaced");
private FProperty FONT_SIZE = fontSize(10);
private FProperty TO_ARROW = toArrow(triangle(5));


void visualize(rel[tuple[loc, str], tuple[loc, str]] g) {
  render(graph2figure(g));
}

str idOf(tuple[loc l, str s] n) = "<n.l.offset>";

FProperty onClick(loc l, str txt) =
    onMouseDown(bool (int butnr, map[KeyModifier,bool] modifiers) {
          edit(l, []);
          return true;
        });

list[Figure] getNodes(rel[tuple[loc, str], tuple[loc, str]] g) {
  ns = g<0> + g<1>;
  str labelOf(tuple[loc, str] n) = n[1];
  
  return [ box(text(labelOf(n), FONT, FONT_SIZE), FProperty::id(idOf(n)), 
               resizable(false), gap(5), onClick(n[0], n[1])) 
           | n <- ns ];
}

Edges getEdges(rel[tuple[loc, str], tuple[loc, str]] g) 
  = [ edge(idOf(a), idOf(b), TO_ARROW) | <a, b> <- g ];

Figure graph2figure(rel[tuple[loc, str], tuple[loc, str]] g) {
  ns = getNodes(g);
  es = getEdges(g);
  return graph(ns, es, gap(50.0,50.0), hint("layered"), orientation(topDown()));
}






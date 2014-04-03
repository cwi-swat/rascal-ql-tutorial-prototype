module Resolve

import AST;
import Message;
import IO;
import ParseTree;
import List;
import Set;

alias Names = rel[loc use, loc def];

Names resolve(Form f) {
  // Lazy because of declare after use.
  map[loc, set[loc]()] useLazy = ();
  rel[Id, loc] env = {};	
  
  // Return a function to look up decls of `n` in env
  set[loc]() lookup(Id n) = set[loc]() { return env[n]; };

  void addDef(Id n, loc q) { env += {<n, q>}; }
  
  visit (f) {
    case var(x): useLazy[x@location] = lookup(x);
    case question(_, x, _):    addDef(x, x@location);
    case computed(_, x, _, _): addDef(x, x@location);
  }
  
  // Force the closures in `useLazy` to resolve references.
  return { <u, d>  | u <- useLazy, d <- useLazy[u]() };
}


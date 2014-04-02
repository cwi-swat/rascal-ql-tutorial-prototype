module Resolve

import AST;
import Message;
import IO;
import ParseTree;
import List;
import Set;

alias Use = rel[loc use, loc def];
alias Def = lrel[loc def, QType tipe];

alias Refs = tuple[Use use, Def def];

alias Labels = rel[str label, loc question];
alias Info = tuple[Refs refs, Labels labels];

Info resolve(Form f) {
  // Lazy because of declare after use.
  map[loc, set[loc]()] useLazy = ();
  Def def = {};
  Labels labels = {};
  
  rel[Id, loc] env = {};	
  
  // Return a function to look up decls of `n` in defs
  set[loc]() lookup(Id n) = set[loc]() { return env[n]; };

  void addUse(loc l, Id name) {
    useLazy[l] = lookup(name);
  }
  
  void addLabel(str label, loc l) {
    labels += {<label, l>};
  }
  
  void addDef(Id n, loc q, QType t) {
    env += {<n, q>};
    def += {<q, t>};
  }
  
  visit (f) {
    case var(x): addUse(x@location, x); 
    case question(l, x, t): {
      addLabel(l, x@location);
      addDef(x, x@location, t);
    }
    case computed(l, x, t, e): {
      addLabel(l, x@location); 
      addDef(x, x@location, t);
    }
  }
  
  // Force the closures in `useLazy` to resolve references.
  use = { <u, d>  | u <- useLazy, d <- useLazy[u]() };
  
  return <<use, def>, labels>;
}

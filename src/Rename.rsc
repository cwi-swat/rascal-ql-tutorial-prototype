module Rename

import AST;
import Resolve;
import IO;
import List;
import String;

str substitute(str src, map[loc,str] s) { 
    int shift = 0;
    str subst1(str src, loc x, str y) {
        delta = size(y) - x.length;
        src = src[0..x.offset+shift] + y + src[x.offset+x.length+shift..];
        shift += delta;
        return src; 
    }
    order = sort([ k | k <- s ], bool(loc a, loc b) { return a.offset < b.offset; });
    return ( src | subst1(it, x, s[x]) | x <- order );
}


set[loc] eqClass(loc n, Use use) {
  // TODO
  return {};
}

str rename(str src, loc x, str new, Refs r) {
  // TODO
  return src;
}
 


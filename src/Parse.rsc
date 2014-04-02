module Parse

import QL;
import ParseTree;

Tree parseQL(loc l) = parse(#start[Form], l);
Tree parseQL(str src) = parse(#start[Form], src);
Tree parseQL(str src, loc l) = parse(#start[Form], src, l);

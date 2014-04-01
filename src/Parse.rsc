module Parse

import QL;
import util::Explode;
import ParseTree;

Tree parseQL(loc l) = parse(#Form, l);
Tree parseQL(str src) = parse(#Form, src);
Tree parseQL(str src, loc l) = parse(#Form, src, l);
Form explode(node n) = explode(#Form, n);

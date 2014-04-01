module Load

import Parse;
import AST;
import ParseTree;

Form load(loc l) = implodeQL(parseQL(l));
Form load(str src) = implodeQL(parseQL(src));
Form loadExample(str file) = load(|project://RascalQLTutorial/examples/<file>|);

Form implodeQL(Tree f) = implode(#Form, f);

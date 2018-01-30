module Parse

import QL;
import ParseTree;

import util::Brackets;
import lang::rascal::grammar::definition::Priorities;


start[Form] parseQL(loc l) = parse(#start[Form], l);
start[Form] parseQL(str src) = parse(#start[Form], src);
start[Form] parseQL(str src, loc l) = parse(#start[Form], src, l);
start[Form] parseExample(str example) = parseQL(|project://RascalQLTutorial/examples/<example>|);

DoNotNest qlPriorities() = prioritiesOf(#Form);
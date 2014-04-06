module exercises::Part1

import AST;
import Resolve;
import IO;
import List;
import String;
import FormatExpr;

/*
 * Exercise 0 (warm-up): FizzBuzz 
 * (see http://c2.com/cgi/wiki?FizzBuzzTest)
 *
 * "Write a program that prints the numbers from 1 to 100. 
 * But for multiples of three print “Fizz” instead of the 
 * number and for the multiples of five print “Buzz”. For 
 * numbers which are multiples of both three and five print
 * “FizzBuzz”."
 *
 * Tip: [1..101] gives the list [1,2,3,...,100]
 * Tip: use println from IO to print.
 */
 
void fizzBuzz() {

}


/*
 * General note: press the Reload icon (two arrows) in the toolbar of the Rascal
 * perspective to reload your change language implementation in
 * editors (next to the Rascal icons).
 */

/*
 * Exercise 1 (evolution): add an unless statement which is to be used
 * similar to ifThen statements: 
 *  unless (x > 1) { "What is your age?" age: int }
 *
 * - add a production to Question in QL.rsc
 * - add a constructor to Question in AST.rsc
 * - add a tc rule to the type checker in Check.rsc
 * - add a normalize rule to the normalize in Normalize.rsc
 *   (note: desugar unless to if(not(e), s))
 *
 * Tip: implement unless analogous to ifThen in all cases
 *
 * Check in the IDE that the type checker indeed signals
 * errors in unless conditions and bodies, and that its
 * conditions appear in the outliner.  
 *
 * Optional: change the typechecker so that a warning
 * is issued in the case of ifThen(not(_), ...).
 * NB: ordering of pattern-based function definitions
 * is irrelevant, use patterns that are mutually exclusive
 * or use side conditions with (when ...)
 *
 * Optional: fix the outliner (Outline) so that unless conditions 
 * appears in the outline
 *
 * Optional: fix the formatter to pretty print unless
 * 
 */

/* 
 * Exercise 2 (evolution): add support for date valued questions
 *
 * - add syntax to QType to allow date fields (Lexical.rsc)
 * - add new QType constructor for date types (AST.rsc)
 * - add new case to type2widget in Compile to generate 
 *   DateValueWidgets (see resources/js/framework/value-widgets.js)
 *
 */
 
/*
 * Exercise 3 (evolution): add a conditional expression x ? y : z
 *  
 *  - add production to Expr (QL.rsc)
 *    (Make sure it's low in the priority hierarchy
 *     i.e. x && y ? a : b  is equal to (x && y) ? a : b.) 
 *  - add new Expr constructor in AST.rsc
 *  - add new case to typeOf in TypeOf.rsc
 *  - add new case to tc in CheckExpr.rsc
 *  - add new case to expr2js in Expr2JS.rsc
 */
 

 
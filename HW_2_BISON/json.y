/* Carlos Santos
** json.y
** CS 210
** Homework 2
** This is a Bison file to parse a json file
*/

%{
// Declare stuff from Flex that Bison needs to know about:
    #include "json.h"
%}

/* Bison Declaratons */
%token TRUE
%token FALSE
%token null
%token LCURLY
%token RCURLY
%token COMMA
%token COLON
%token LBRACKET
%token RBRACKET
%token STRINGLIT
%token NUMBER

%% /*  The Grammer follows. */

//  whitespace is ignored in flex file
object
    : LCURLY RCURLY
    | LCURLY object_center RCURLY
;

object_center
    : STRINGLIT COLON value
    | STRINGLIT COLON value COMMA object_center
;

array
    : LBRACKET array_center RBRACKET
;

array_center
    : value
    | COMMA array_center
;

number
    : NUMBER
    | '-' NUMBER // negative number
    | NUMBER '.' NUMBER // fraction number
    | 'E' '-' NUMBER // exponential
    | 'e' '-' NUMBER // exponential
    | 'E' '+' NUMBER // exponential
    | 'e' '+' NUMBER // exponential
;

value
    : STRINGLIT 
    |  number 
    |  object 
    |  array 
    |  TRUE 
    |  FALSE 
    |  null 
;



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
object: LCURLY " " RCURLY | LCURLY " " STRINGLIT " " COLON value RCURLY |  ;

// find out how to do 1 more of value COMMA value
array: LBRACKET " " RBRACKET | LBRACKET "\t" RBRACKET | 
LBRACKET value RBRACKET | value COMMA value; 

value: " " STRINGLIT " " | "\n" STRINGLIT "\n" | "\t" STRINGLIT "\t" |
" " TRUE " " | "\n" TRUE "\n" | "\t" TRUE "\t" |
" " FALSE " " | "\n" FALSE "\n" | "\t" FALSE "\t" |
" " null " " | "\n" null "\n" | "\t" null "\t" |
" " NUMBER " " | "\n" NUMBER "\n" | "\t" NUMBER "\t" ;


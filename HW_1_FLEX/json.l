/* Carlos Santos
** CS 210
** Homework 1
** This is a Flex file to parse a json file
*/

%{
#include "json.h"
%}

%option yylineno
%option noyywrap

DIG [0-9]
LET [a-fA-F]
HEX   0[xX]digit+

%%
"TRUE" {return TRUE;}
"FALSE" {return FALSE;}
[*{*] {return LCURLY;}
[*}*] {return RCURLY;}
[*,*] {return COMMA;}
[*;*] {return COLON;}
[*[*] {return LBRACKET;}
[*]*] {return RBRACKET;}
[*"{[LET}+"*] {return STRINGLIT;}
.		{ printf("lexical error: line %d\n",yylineno); }

%%
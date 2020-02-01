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

digit [0-9]
alpha [a-fA-F]
hex   0[xX]digit+

%%
[*{*] {return LCURLY;}
[*}*] {return RCURLY;}
[*,*] {return COMMA;}
[*;*] {return COLON;}
[*[*] {return LBRACKET;}
[*]*] {return RBRACKET;}
.		{ printf("lexical error on line %d\n",yylineno); }

%%
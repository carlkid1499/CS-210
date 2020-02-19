/* Carlos Santos
** json.l
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
FRAC {DIG}[.]{DIG}
EXP {E}{DIG}
E [eE][+-]?

%%
"true"|"TRUE" {return TRUE;}
"false"|"FALSE" {return FALSE;}
"null"|"NULL" {return null;}
"{" {return LCURLY;} // inside [] * only means and '*'
"}" {return RCURLY;}
"," {return COMMA;}
":" {return COLON;}
"[" {return LBRACKET;}
"]" {return RBRACKET;}

\"(\\.|[^"\\])*\" {return STRINGLIT;} /* This matches strings! http://stackoverflow.com/questions/2039795/ddg#2039820
What I don't is why \"(\\.|[^"\\])*\" works but not [\"(\\.|[^"\\])*\"] ... look this up later.
*/
{DIG}+ {return NUMBER;} /* matches number like 00000+ */
[ \t\n\r] /* skip whitespace */
.		{ printf("lexical error: line %d\n",yylineno); }

%%
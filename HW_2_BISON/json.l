/* Carlos Santos
** json.l
** CS 210
** Homework 2
** This is a Flex file to parse a json file
*/

%{
#include "json.tab.h"
#include "tree.h"
YYSTYPE yylval;
%}

%option yylineno
%option noyywrap

DIG [0-9]
LET [a-fA-F]
FRAC {DIG}[.]{DIG}
EXP {E}{DIG}
E [eE][+-]?

%%
"true"|"TRUE" {yylval.np = alcleaf(TRUE, yytext); return TRUE;}
"false"|"FALSE" {yylval.np = alcleaf(FALSE, yytext); return FALSE;}
"null"|"NULL" {yylval.np = alcleaf(null, yytext); return null;}
"{" {yylval.np = alcleaf('{', yytext); return LCURLY;} // inside [] * only means and '*'
"}" {yylval.np = alcleaf('}', yytext); return RCURLY;}
"," {yylval.np = alcleaf(',', yytext); return COMMA;}
":" {yylval.np = alcleaf(':', yytext); return COLON;}
"[" {yylval.np = alcleaf('[', yytext); return LBRACKET;}
"]" {yylval.np = alcleaf(']', yytext); return RBRACKET;}

\"(\\.|[^"\\])*\" {yylval.np = alcleaf(STRINGLIT, yytext); return STRINGLIT;} /* This matches strings! http://stackoverflow.com/questions/2039795/ddg#2039820
What I don't is why \"(\\.|[^"\\])*\" works but not [\"(\\.|[^"\\])*\"] ... look this up later.
*/
{DIG}+ {yylval.np = alcleaf(NUMBER, yytext); return NUMBER;} /* matches number like 00000+ */
[ \t\n\r] /* skip whitespace */
.		{ printf("lexical error: line %d\n",yylineno); }

%%
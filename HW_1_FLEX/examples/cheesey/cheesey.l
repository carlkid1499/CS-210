%{
/* The quick brown fox jumped the lazy yellow dog.
All Gaul is divided into three parts. */
#include <stdio.h>
%}

%option yylineno
%option noyywrap

%%

[ \n]		{ /* skip */ }
[a-zA-Z]+	{ return 1; }
"."		{ return 2; }
.		{ printf("lexical error on line %d\n", yylineno); }

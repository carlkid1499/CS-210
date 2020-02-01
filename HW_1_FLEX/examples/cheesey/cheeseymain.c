#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
extern char *yytext;
extern int yylineno;

int main(int argc, char *argv[])
{
   int i;
   if (argc < 2) { fprintf(stderr, "usage: prog filename\n"); exit(1); }
   yyin = fopen(argv[1], "r");
   if (yyin == NULL) { fprintf(stderr, "usage: prog filename\n"); exit(1); }
   while ((i = yylex()) > 0) {
      printf("i %d lineno %d text %s\n", i, yylineno, yytext);
      }
}

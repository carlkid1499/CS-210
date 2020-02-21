/* Carlos Santos
** main.c
** CS 210
** Homework 2
** This main file for the HW 2 project. Some of the code was provided by Dr. Jefferey. (DR. J)
** Addtions: error funtions and yydebug stuff.
*/

#include <stdio.h>
#include <stdlib.h>
#include "json.tab.h"
#include "tree.h"
#include "prodrules.h"

extern FILE *yyin;
extern char *yytext;
extern int yylineno;
//extern int yydebug;
char *yyfilename;
void yyerror(char *s);

int main(int argc, char *argv[])
{
   // yydebug = 1 ;
   int i;
   if (argc < 2)
   {
      printf("usage: iscan file.dat\n");
      exit(-1);
   }
   yyin = fopen(argv[1], "r");
   if (yyin == NULL)
   {
      printf("can't open/read '%s'\n", argv[1]);
      exit(-1);
   }
   yyfilename = argv[1];
   if ((i = yyparse()) != 0)
   {
      printf("parse failed\n");
   }
   else
   {
      printf("\n\nno errors priting sytaxt tree: \n\n");
      treeprint(yyroot); // print the syntax tree
   }

   return 0;
}
/* error function for Bison */
void yyerror(char *s)
{
   fprintf(stderr, "%s:%d: %s before '%s' token\n", yyfilename, yylineno, s, yytext);
}
/* Carlos Santos
** tree.c
** CS 210
** Homework 2
** This is the main tree file for the bision file
** Code modified and grabbed from Dr. J's examples.
*/

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "tree.h"

/*
 * Given a terminal or non-terminal symbol code,
 * allocate a parse tree node for it.
 * THE REST OF THE INITIALIZATION DEPENDS ON THE CALLER.
 */

struct node *treenode(int symbol)
{
   struct node *p = (struct node *)calloc(1, sizeof(struct node));
   if (p == NULL)
      printf("out of memory in treenode constructor");
   p->symbol = symbol;
   return p;
}

struct node *alcleaf(int symbol, char *lexeme) // alocated a leaf
{
   struct node *ret = treenode(symbol);
   ret->u.t.lexeme = strdup(lexeme);
   return ret;
}

struct node *alcnary(int symbol, int prodrule, int nkids, ...)
{
   int i;
   va_list mylist;
   struct node *rv = treenode(symbol);
   rv->u.nt.production_rule = prodrule;
   va_start(mylist, nkids);
   for (i = 0; i < nkids; i++)
   {
      rv->u.nt.child[i] = va_arg(mylist, struct node *);
      printf("set child %d to %p\n", rv->u.nt.child[i]);
   }
   va_end(mylist);
   return rv;
}

void treeprint(struct node *np)
{ /* Check for null */
   if (np == NULL)
   {
      printf("NULL tree pointer");
      return;
   }
   else
   {

      /* Print symbols*/
      if (np->symbol < 1000)
      {
         printf("\t %s ", np->u.t.lexeme);
         printf("\t");
         fflush(stdout);
      }
    else
      {
         int i;
         /* print the children */
         for (i = 0; i < child_size; i++)
         {  
            if(np->u.nt.child[i] != NULL)
            treeprint(np->u.nt.child[i]);
            else
            {
               /* do nothing you are done */
            }
            
         }
      }
   }
}
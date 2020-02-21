/* Carlos Santos
** tree.h
** CS 210
** Homework 2
** This is the tree header file for the bision file
** Code modified and grabbed from Dr. J's examples.
*/

#define child_size 5
struct node
{
   int symbol; /* <1000 is terminal, >=1000 is non-terminal */
   union {
      struct leaf
      {
         char *lexeme; /* saved copy of yytext */
         int val;      /* saved copy of val */
      } t;
      struct nonleaf
      {
         int production_rule;
         struct node *child[child_size]; /* 9 not big enough for some grammars */
      } nt;
   } u;
};

struct node *treenode(int symbol);
struct node *alcleaf(int symbol, char *lexeme);
struct node *alcnary(int symbol, int prodrule, int nkids, ...);
void treeprint(struct node *np);

struct node *yyroot;
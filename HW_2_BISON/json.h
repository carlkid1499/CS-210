/* Carlos Santos
** json.h
** CS 210
** Provided by Dr J.
** 2/5/2020
*/

#include "json.tab.h"

/* header file for JSON tokens, codes from json.org */

#define TRUE      1
#define FALSE     2
#define null      3
#define LCURLY   '{'
#define RCURLY   '}'
#define COMMA    ','
#define COLON    ':'
#define LBRACKET '['
#define RBRACKET ']'
#define STRINGLIT 4
/* #define CHARLIT 5 json does not have character literals! */
#define NUMBER    6
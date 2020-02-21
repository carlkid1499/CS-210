/* Carlos Santos
** json.y
** CS 210
** Homework 2
** This is a Bison file to parse a json file
*/

%{
// Declare stuff from Flex that Bison needs to know about:
    #include "json.tab.h"
    #include "tree.h"
    #include "prodrules.h"
    #include <stdio.h>
%}

/* Bison Declaratons */
%union 
{
    struct node *np;
}

%token <np> TRUE
%token <np> FALSE
%token <np> null
%token <np> LCURLY
%token <np> RCURLY
%token <np> COMMA
%token <np> COLON
%token <np> LBRACKET
%token <np> RBRACKET
%token <np> STRINGLIT
%token <np> NUMBER
%token <np> '+' '-' '.' 'E' 'e'
%type <np> start object object_center array array_center number value
%% /*  The Grammer follows. */

start
    : object { yyroot = $1 ; printf("Setting Parse Rule: yyroot to %p\n", yyroot); } ; /* start the tree */
;


//  Note: whitespace is ignored in flex file
object
    : LCURLY RCURLY { $$ = alcnary(OBJECT, OBJECT_R1, 2, $1, $2); printf("Setting Parse Rule: object $$ to %p\n", $$); }
    | LCURLY object_center RCURLY { $$ = alcnary(OBJECT, OBJECT_R2, 3, $1, $2, $3); printf("Setting Parse Rule: object $$ to %p\n", $$); }
;

object_center
    : STRINGLIT COLON value { $$ = alcnary(OBJECT_CENTER, OBJECT_CENTER_R1, 3, $1, $2, $3); printf("Setting Parse Rule: object_center $$ to %p\n", $$); }
    | STRINGLIT COLON value COMMA object_center { $$ = alcnary(OBJECT_CENTER, OBJECT_CENTER_R2, 5, $1, $2, $3,$4,$5); printf("Setting Parse Rule: object_center $$ to %p\n", $$); }
;

array
    : LBRACKET array_center RBRACKET { $$ = alcnary(ARRAY, ARRAY_R1, 3, $1, $2, $3); printf("Setting Parse Rule: array $$ to %p\n", $$); }
;

array_center
    : value { $$ = alcnary(ARRAY_CENTER, ARRAY_CENTER_R1, 1, $1); printf("Setting Parse Rule: array_center $$ to %p\n", $$); }
    | value COMMA array_center { $$ = alcnary(ARRAY_CENTER, ARRAY_CENTER_R2, 3, $1, $2, $3); printf("Setting Parse Rule: array_center $$ to %p\n", $$); }
;

number
    : NUMBER { $$ = alcnary(NUMBER, NUMBER_R1, 1, $1); printf("Setting Parse Rule: number $$ to %p\n", $$); }
    | '-' NUMBER { $$ = alcnary(NUMBER, NUMBER_R2, 2, $1,$2); printf("Setting Parse Rule: number $$ to %p\n", $$); } // negative number 
    | NUMBER '.' NUMBER { $$ = alcnary(NUMBER, NUMBER_R3, 3, $1,$2,$3); printf("Setting Parse Rule: array $$ to %p\n", $$); } // fraction number 
    | 'E' '-' NUMBER { $$ = alcnary(NUMBER, NUMBER_R4, 3, $1,$2,$3); printf("Setting Parse Rule: number $$ to %p\n", $$); } // exponential
    | 'e' '-' NUMBER { $$ = alcnary(NUMBER, NUMBER_R5, 3, $1,$2,$3); printf("Setting Parse Rule: number $$ to %p\n", $$); } // exponential
    | 'E' '+' NUMBER { $$ = alcnary(NUMBER, NUMBER_R6, 3, $1,$2,$3); printf("Setting Parse Rule: number $$ to %p\n", $$); } // exponential
    | 'e' '+' NUMBER { $$ = alcnary(NUMBER, NUMBER_R7, 3, $1,$2,$3); printf("Setting Parse Rule: number $$ to %p\n", $$); } // exponential
;

value
    : STRINGLIT { $$ = alcnary(VALUE, VALUE_R1, 1, $1); printf("Setting Parse Rule: value $$ to %p\n", $$); }
    |  number { $$ = alcnary(VALUE, VALUE_R1, 1, $1); printf("Setting Parse Rule: value $$ to %p\n", $$); }
    |  object { $$ = alcnary(VALUE, VALUE_R1, 1, $1); printf("Setting Parse Rule: value $$ to %p\n", $$); }
    |  array { $$ = alcnary(VALUE, VALUE_R1, 1, $1); printf("Setting Parse Rule: value $$ to %p\n", $$); }
    |  TRUE { $$ = alcnary(VALUE, VALUE_R1, 1, $1); printf("Setting Parse Rule: value $$ to %p\n", $$); }
    |  FALSE { $$ = alcnary(VALUE, VALUE_R1, 1, $1); printf("Setting Parse Rule: value $$ to %p\n", $$); }
    |  null { $$ = alcnary(VALUE, VALUE_R1, 1, $1); printf("Setting Parse Rule: value $$ to %p\n", $$); }
;




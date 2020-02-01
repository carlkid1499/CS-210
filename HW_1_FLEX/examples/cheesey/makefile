	
# flex makefile.
#

cheesey: cheeseymain.o lex.yy.o
	gcc -o cheesey cheeseymain.o lex.yy.o

cheeseymain.o: cheeseymain.c
	gcc -c -g -DLEX cheeseymain.c

lex.yy.o: lex.yy.c
	gcc -c -g lex.yy.c

lex.yy.c: cheesey.l
	flex cheesey.l
# flex makefile.
# Carlos Santos
# HW 2
# CS 210 2/21/2020

	
jsonpp: main.o lex.yy.o json.tab.o tree.o
	cc -o jsonpp main.o lex.yy.o json.tab.o tree.o -ll

main.o: main.c json.tab.h tree.h prodrules.h
	cc -c -g main.c

lex.yy.o: lex.yy.c
	cc -c -g lex.yy.c

lex.yy.c: json.l json.tab.h
	flex json.l

json.tab.o: json.tab.c
	cc -c -g json.tab.c

tree.o: tree.c tree.h
	cc -c -g tree.c

json.tab.c: json.y
	bison json.y
	
json.tab.h: json.y
	bison -d json.y

run:
	./jsonpp test.json

run1:
	./jsonpp color.json

clean:
	rm *.tab.* *.yy.* t*.o m*.o
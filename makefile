my_compiler: lex.yy.o y.tab.o
	gcc lex.yy.o y.tab.o -o my_compiler -ll

lex.yy.o: lex.yy.c y.tab.h
	gcc -c lex.yy.c

y.tab.o: y.tab.c y.tab.h
	gcc -c y.tab.c

lex.yy.c: mylex.lex
	flex mylex.lex

y.tab.h: myyacc.y
	yacc -d myyacc.y

y.tab.c: myyacc.y
	yacc -d myyacc.y

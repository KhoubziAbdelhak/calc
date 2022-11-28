
calc: lex.yy.c y.tab.c
	gcc -g lex.yy.c calc.tab.c -o calc

lex.yy.c: y.tab.c calc.l
	lex calc.l

y.tab.c: calc.y
	bison -d calc.y
	
clean:
	rm -rf lex.yy.c calc.tab.h calc.tab.c calc


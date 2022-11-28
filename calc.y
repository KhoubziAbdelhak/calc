%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	int yylex();
	void yyerror(char *s);
	int Symbols[26];
	int symbolVal(char s);
	void updateSymbolVal(char s, int val);
%}

%union{
	int val;
	char sym;
}

%start line
%token print
%token exit_command
%token CR
%token <val> number
%token <sym> identifier
%type <val> line exp e1 term 
%type <sym> assignment


%%

line: assignment CR				{;}
	| line assignment CR		{;}
	| print exp	CR				{printf("printing %d\n", $2);}
	| line print exp CR		 	{printf("printing %d\n", $3);}
	| exit_command CR			{exit(EXIT_SUCCESS);}
	| line exit_command CR		{exit(EXIT_SUCCESS);}
	;

assignment: identifier '=' exp		{updateSymbolVal($1, $3);}
		  ;



exp: exp '+' e1			{$$ = $1 + $3;}
   | exp '-' e1 		{$$ = $1 - $3;}
   | e1					{$$ = $1;}
   ;

e1: e1 '*' term			{$$ = $1 * $3;}
  | e1 '/' term			{$$ = $1 / $3;}
  | term				{$$ = $1;}
  ;

term: identifier		{$$ = symbolVal($1);}
	| number			{$$ = $1;}
	;
	

%%


int calculIndex(char s) {
	return (s - 'a');
}


void updateSymbolVal(char s, int val) {
	int index = calculIndex(s);
	Symbols[index] = val;
}

int symbolVal(char s) {
	int index = calculIndex(s);
	return Symbols[index];
}




int main(void) {

	for(int i=0; i<26; i++) {
		Symbols[i] = 0;
	}
	
	return yyparse();
}


void yyerror(char *s) {fprintf(stderr, "%s\n", s);}


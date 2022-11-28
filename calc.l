
%{
	#include "calc.tab.h"
	int yylex();
	void yyerror(char *s);
%}

%%

"print"			{return print;}
"exit"			{return exit_command;}
[a-z]			{yylval.sym = yytext[0]; return identifier;}
[0-9]+			{yylval.val = atoi(yytext); return number;}
[\n]			{return CR;}
[ \t]			;
[-+*/=]			{return yytext[0];}
.				{ECHO; yyerror("unexpected character");}


%%

int yywrap(void) {return 1;}





%{
#include "yc5508.hwchecker.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
":"         { return COLON; }
"="         { return EQ; }
"<"         { return LT; }
">"         { return GT; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return TIMES; }
"/"         { return DIV; }
"("         { return LPAREN; }
")"         { return RPAREN; }
\n          { return '\n'; }
[ \t]       ;   /* ignore space and tab */
.           { return yytext[0]; }  /* Other symbols */

%%

int yywrap(void) { return 1; }

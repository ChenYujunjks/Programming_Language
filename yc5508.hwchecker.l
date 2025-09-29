%option noyywrap

%{
#include <stdlib.h>
#include "yc5508.hwchecker.tab.h"
%}

DIGIT   [0-9]+

%%
[ \t\r]+           ;
\n                 return '\n';
":"                return ':';
"("                return '(';
")"                return ')';
"+"                return '+';
"-"                return '-';
"*"                return '*';
"/"                return '/';
"<"                return '<';
">"                return '>';
"="                return '=';
{DIGIT}            { yylval.ival = atoll(yytext); return NUM; }
[A-Za-z_][A-Za-z_0-9]*   { return VARIABLE; }
.                  { return yytext[0]; }
%%

%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int expected_line = 1;   
%}

%output "yc5508.hwchecker.tab.c"
%defines "yc5508.hwchecker.tab.h"


%token NUMBER
%token EQ LT GT
%token PLUS MINUS TIMES DIV
%token LPAREN RPAREN
%token COLON

%left LT GT EQ
%left PLUS MINUS
%left TIMES DIV
%left UMINUS

%%

input:
  | input line
  ;

line:
    NUMBER COLON comparison '\n' {
     
        if ($1 != expected_line) {
            fprintf(stderr, "Error: Line numbering out of sequence (expected %d:, got %d:)\n", expected_line, $1);
            exit(1);  
        }
        expected_line++;

        if ($3 == -99999) {

        } else if ($3) {
            printf("%d: Yes\n", $1);
        } else {
            printf("%d: No\n", $1);
        }
    }
  ;

comparison:
    expr EQ expr {
        $$ = ($1 == $3);
    }
  | expr LT expr {
        $$ = ($1 < $3);
    }
  | expr GT expr {
        $$ = ($1 > $3);
    }
  | expr { 
        
        $$ = $1 != 0;
    }
  ;

expr:
    expr PLUS expr   { $$ = $1 + $3; }
  | expr MINUS expr  { $$ = $1 - $3; }
  | expr TIMES expr  { $$ = $1 * $3; }
  | expr DIV expr    { 
        if ($3 == 0) {
            printf("Error: Division by Zero\n");
            $$ = -99999;  
        } else {
            $$ = $1 / $3;  
        }
    }
  | LPAREN expr RPAREN { $$ = $2; }
  | MINUS expr %prec UMINUS { $$ = -$2; }
  | NUMBER { $$ = $1; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: syntax error\n");
    exit(1); 
}

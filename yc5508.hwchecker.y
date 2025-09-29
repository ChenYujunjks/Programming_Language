%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char* s);

static long long expected_line = 1;
static int had_divzero = 0;
%}

%union {
    long long ival;
}

%token <ival> NUM
%token VARIABLE

%type <ival> stmt eq_stmt ineq_stmt expr term factor

%%

input
  : 
  | input line
  ;

line
  : NUM ':' stmt '\n'
    {
        if ($1 != expected_line) {
            yyerror("syntax error");
        }
        if (!had_divzero) {
            printf("%lld: %s\n", $1, ($3 ? "Yes" : "No"));
        }
        had_divzero = 0;
        expected_line++;
    }
  ;

stmt
  : eq_stmt
  | ineq_stmt
  ;

eq_stmt
  : expr '=' expr
    { $$ = ($1 == $3); }
  ;

ineq_stmt
  : expr '<' expr          { $$ = ($1 < $3); }
  | expr '>' expr          { $$ = ($1 > $3); }
  | ineq_stmt '<' expr     { $$ = ($1 < $3); }
  | ineq_stmt '>' expr     { $$ = ($1 > $3); }
  ;

expr
  : expr '+' term          { $$ = $1 + $3; }
  | expr '-' term          { $$ = $1 - $3; }
  | term
  ;

term
  : term '*' factor        { $$ = $1 * $3; }
  | term '/' factor
    {
        long long a = $1, b = $3;
        if (b == 0) {
            if (!had_divzero) {
                fprintf(stdout, "Error: Division by Zero\n");
                fflush(stdout);
                had_divzero = 1;
            }
            $$ = 0;
        } else {
            long long q = a / b;
            long long r = a % b;
            if (r != 0 && ((a < 0) ^ (b < 0))) {
                q -= 1;
            }
            $$ = q;
        }
    }
  | factor
  ;

factor
  : '(' expr ')'           { $$ = $2; }
  | '-' factor             { $$ = -$2; }
  | '+' factor             { $$ =  $2; }
  | NUM                    { $$ = $1; }
  ;

%%

void yyerror(const char* s) {
    (void)s;
    fprintf(stdout, "Error: syntax error\n");
    exit(1);
}

int main(void) {
    return yyparse();
}

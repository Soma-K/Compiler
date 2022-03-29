%option noyywrap

%{
// Avoid err "error: `fileno' was not declared in this scope"
extern "C" int fileno(FILE *stream);

#include "parser.tab.hpp"
%}

%%


"void"         { return T_TYPE_VOID; }
"char"         { return T_TYPE_CHAR; }
"int"          { return T_TYPE_INT; }
"long"         { return T_TYPE_LONG; }
"float"         { return T_TYPE_FLOAT; }
"double"         { return T_TYPE_DOUBLE; }
"signed"         { return T_TYPE_SIGNED; }
"unsigned"         { return T_TYPE_UNSIGNED; }




[*]             { return T_TIMES; }
[+]             { return T_PLUS; }
[\^]            { return T_EXPONENT; }
[-]             { return T_MINUS; }
[/]             { return T_DIVIDE; }

[(]             { return T_LBRACKET; }
[)]             { return T_RBRACKET; }

log             { return T_LOG; }
exp             { return T_EXP; }
sqrt            { return T_SQRT; }

[{]             { return T_L_CURLY_BRACKET; }
[}]             { return T_R_CURLY_BRACKET; }








[0-9]+([.][0-9]*)? { yylval.number=strtod(yytext, 0); return T_NUMBER; }
[a-z]+          { yylval.string=new std::string(yytext); return T_VARIABLE; }

[ \t\r\n]+		{;}

[a-zA-Z_][a-zA-Z0-9_]*      { yylval.string = new std::string(yytext); return (T_IDENTIFIER); }

.               { fprintf(stderr, "Invalid token\n"); exit(1); }
%%

void yyerror (char const *s)
{
  fprintf (stderr, "Parse error actually here : %s\n", s);
  exit(1);
}

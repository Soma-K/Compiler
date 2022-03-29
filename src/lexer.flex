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

[%]             { return T_MOD; }
[+][+]            { return T_INCREMENT; }
[-][-]            { return T_DECREMENT; }

[=][=]            { return T_EQUALS; }
[!][=]            { return T_NOTEQUALS; }
[<]             { return T_LESSTHAN; }
[>]             { return T_GREATERTHAN; }
[>][=]            { return T_GREATERTHANEQUALS; }
[<][=]            { return T_LESSTHANEQUALS; }

[&][&]            { return T_AND; }
[|][|]            { return T_OR; }
[!]             { return T_NOT; }

[&]             { return T_BITWISEAND; }
[|]             { return T_BITWISEOR; }

[~]             { return T_BITWISEFLIP; }
[<][<]            { return T_SHIFTLEFT; }
[>][>]            { return T_SHIFTRIGHT; }


log             { return T_LOG; }
exp             { return T_EXP; }
sqrt            { return T_SQRT; }

[{]             { return T_L_CURLY_BRACKET; }
[}]             { return T_R_CURLY_BRACKET; }








[0-9]+([.][0-9]*)? { yylval.number=strtod(yytext, 0); return T_NUMBER; }
[a-z]+          { yylval.string=new std::string(yytext); return T_VARIABLE; }

[ \t\r\n]+		{;}

[a-z]+      { yylval.string = new std::string(yytext); return (T_IDENTIFIER); }

.               { fprintf(stderr, "Invalid token\n"); exit(1); }
%%

void yyerror (char const *s)
{
  fprintf (stderr, "Parse error actually here : %s\n", s);
  exit(1);
}
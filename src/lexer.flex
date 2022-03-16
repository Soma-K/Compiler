%option noyywrap

%{
// Avoid error ]error: `fileno' was not declared in this scope]
extern ]C] int fileno(FILE *stream);

#include ]maths_parser.tab.hpp]
%}

%%

"auto"		{return(T_AUTO);}
"break"		{return(T_BREAK);}
"case"		{return(T_CASE);}
"char"		{return(T_CHAR);}
"const"		{return(T_CONST);}
"continue"	{return(T_CONTINUE);}
"default"	{return(T_DEFAULT);}
"do"		{return(T_DO);}
"double"		{return(T_DOUBLE);}
"else"		{return(T_ELSE);}
"enum"		{return(T_ENUM);}
"extern"		{return(T_EXTERN); 
"float"		{return(T_FLOAT);}
"for"		{return(T_FOR);}
"goto"		{return(T_GOTO);}
"if"		{return(T_IF);}
"int"		{return(T_INT);}
"long"		{return(T_LONG);}
"register"	{return(T_REGISTER);}
"return"		{return(T_RETURN);}
"short"		{return(T_SHORT);}
"signed"		{return(T_SIGNED);}
"sizeof"		{return(T_SIZEOF);}
"static"		{return(T_STATIC);}
"struct"		{return(T_STRUCT);}
"switch"		{return(T_SWITCH);}
"typedef"	{return(T_TYPEDEF);}
"union"		{return(T_UNION);}
"unsigned"	{return(T_UNSIGNED);}
"void"		{return(T_VOID);}
"volatile"	{return(T_VOLATILE);}
"while"		{return(T_WHILE);}
[>>=]		{return(T_RIGHT_ASSIGN);}
[<<=]		{return(T_LEFT_ASSIGN);}
[+=]		{return(T_ADD_ASSIGN);}
[-=]		{return(T_SUB_ASSIGN);}
[*=]		{return(T_MUL_ASSIGN);}
[/=]		{return(T_DIV_ASSIGN);}
[%=]		{return(T_MOD_ASSIGN);}
[&=]		{return(T_AND_ASSIGN);}
[^=]		{return(T_XOR_ASSIGN);}
[|=]		{return(T_OR_ASSIGN);}
[>>]		{return(T_RIGHT_OP);}
[<<]		{return(T_LEFT_OP);}
[++]		{return(T_INC_OP);}
[--]		{return(T_DEC_OP);}
[->]		{return(T_PTR_OP);}
[&&]		{return(T_AND_OP);}
[||]		{return(T_OR_OP);}
[<=]		{return(T_LE_OP);}
[>=]		{return(T_GE_OP);}
[==]		{return(T_EQ_OP);}
[!=]		{return(T_NE_OP);}
[;]		{return(T_SEMICOLON);}
[{]		{return(T_CURLY_LBRACKET);}
[}]		{return(T_CURLY_RBRACKET);}
[,]		{return(T_COMMA);}
[:]		{return(T_COLON);}
[=]		{return(T_ASSIGN);}
[(]		{return(T_LBRACKET);}
[)]		{return(T_RBRACKET);}
[[]		{return(T_SQUARE_LBRACKET);}
[]]		{return(T_SQUARE_RBRACKET);}
[&]		{return(T_BITWISE_AND);}
[!]		{return(T_NOT);}
[-]		{return(T_SUBSTRACT);}
[+]		{return(T_ADD);}
[*]		{return(T_MULTIPLY);}
[/]		{return(T_DIVIDE);}
[%]		{return(T_MODOLUS);}
[<]		{return(T_LTAN);}
[>]		{return(T_GTHAN);}
[^]		{return(T_BITWISE_XOR);}
[|]		{return(T_BITWISE_OR);}
[?]		{return(T_QMARK);}

.               { fprintf(stderr, ]Invalid token\n]); exit(1); }
%%

void yyerror (char const *s)
{
  fprintf (stderr, ]Parse error : %s\n], s);
  exit(1);
}

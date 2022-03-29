/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SRC_PARSER_TAB_HPP_INCLUDED
# define YY_YY_SRC_PARSER_TAB_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 1 "src/parser.y" /* yacc.c:1909  */

  #include "ast.hpp"
  #include <vector>
  #include <cassert>

  extern const Expression *g_root; 
  int yylex(void);
  void yyerror(const char *);

#line 54 "src/parser.tab.hpp" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_TIMES = 258,
    T_DIVIDE = 259,
    T_PLUS = 260,
    T_MINUS = 261,
    T_EXPONENT = 262,
    T_MOD = 263,
    T_INCREMENT = 264,
    T_DECREMENT = 265,
    T_EQUALS = 266,
    T_NOTEQUALS = 267,
    T_LESSTHAN = 268,
    T_GREATERTHAN = 269,
    T_LESSTHANEQUALS = 270,
    T_GREATERTHANEQUALS = 271,
    T_AND = 272,
    T_NOT = 273,
    T_OR = 274,
    T_BITWISEAND = 275,
    T_BITWISEOR = 276,
    T_BITWISEXOR = 277,
    T_BITWISEFLIP = 278,
    T_SHIFTLEFT = 279,
    T_SHIFTRIGHT = 280,
    T_LBRACKET = 281,
    T_RBRACKET = 282,
    T_L_CURLY_BRACKET = 283,
    T_R_CURLY_BRACKET = 284,
    T_LOG = 285,
    T_EXP = 286,
    T_SQRT = 287,
    T_NUMBER = 288,
    T_VARIABLE = 289,
    T_INT = 290,
    T_IDENTIFIER = 291,
    T_RETURN = 292,
    T_SEMICOLON = 293,
    T_COMMA = 294,
    T_TYPE_VOID = 295,
    T_TYPE_CHAR = 296,
    T_TYPE_INT = 297,
    T_TYPE_LONG = 298,
    T_TYPE_FLOAT = 299,
    T_TYPE_DOUBLE = 300,
    T_TYPE_SIGNED = 301,
    T_TYPE_UNSIGNED = 302
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 12 "src/parser.y" /* yacc.c:1909  */

  const Expression *expr;
  double number;
  std::string *string;
  const Expression *node;

#line 121 "src/parser.tab.hpp" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SRC_PARSER_TAB_HPP_INCLUDED  */

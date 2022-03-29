%code requires{
  #include "ast.hpp"

  #include <cassert>

  extern const Expression *g_root; // A way of getting the AST out

  //! This is to fix problems when generating C++
  // We are declaring the functions provided by Flex, so
  // that Bison generated code can call them.
  int yylex(void);
  void yyerror(const char *);
}

// Represents the value associated with any kind of
// AST node.
%union{
  const Expression *expr;
  double number;
  std::string *string;
  const Expression *node;
}

%token T_TIMES T_DIVIDE T_PLUS T_MINUS T_EXPONENT
%token T_MOD T_INCREMENT T_DECREMENT
%token T_EQUALS T_NOTEQUALS T_LESSTHAN T_GREATERTHAN T_LESSTHANEQUALS T_GREATERTHANEQUALS
%token T_AND T_NOT T_OR
%token T_BITWISEAND T_BITWISEOR T_BITWISEXOR T_BITWISEFLIP T_SHIFTLEFT T_SHIFTRIGHT
%token T_LBRACKET T_RBRACKET T_L_CURLY_BRACKET T_R_CURLY_BRACKET
%token T_LOG T_EXP T_SQRT
%token T_NUMBER T_VARIABLE
%token T_INT
%token T_IDENTIFIER

%token T_TYPE_VOID T_TYPE_CHAR T_TYPE_INT T_TYPE_LONG T_TYPE_FLOAT T_TYPE_DOUBLE T_TYPE_SIGNED T_TYPE_UNSIGNED


%type <expr> EXPR TERM UNARY FACTOR
%type <number> T_NUMBER
%type <string> T_VARIABLE T_LOG T_EXP T_SQRT FUNCTION_NAME T_IDENTIFIER T_TYPE_VOID T_TYPE_CHAR T_TYPE_INT T_TYPE_LONG T_TYPE_FLOAT T_TYPE_DOUBLE T_TYPE_SIGNED T_TYPE_UNSIGNED
%type <string> FUNCTION_DECLARATION
//%type <declaration_node> declaration parameter_declaration
//%type <declaration_list_vector> declaration_list parameter_list




%start ROOT

%%

/* The TODO notes a are just a guide, and are non-exhaustive.
   The expectation is that you do each one, then compile and test.
   Testing should be done using patterns that target the specific
   feature; the testbench is there to make sure that you haven't
   broken anything while you added it.
*/

ROOT : FUNCTION_DECLARATION{ g_root = $1; }

FUNCTION_DECLARATION : T_TYPE_INT T_VARIABLE T_LBRACKET T_RBRACKET T_L_CURLY_BRACKET EXPR T_R_CURLY_BRACKET { $$ = new Functiondeclaration(*$2); }

EXPR : EXPR T_MINUS TERM   { $$ = new SubOperator ( $1 , $3); }
     | EXPR T_PLUS TERM   { $$ = new AddOperator ( $1 , $3); }
     | TERM { $$ = $1; }   

TERM : TERM T_TIMES UNARY           { $$ = new MulOperator ( $1, $3 ); }
     | TERM T_DIVIDE UNARY         { $$ = new DivOperator ( $1, $3 ); }
     | UNARY  { $$ = $1; }  

UNARY : T_MINUS FACTOR { $$ = new NegOperator ( $2 ); } 
      | FACTOR T_EXPONENT UNARY      { $$ = new ExpOperator ( $1, $3 ); }
      | FACTOR         { $$ = $1; }


FACTOR : T_NUMBER     { $$ = new Number( $1 );  }
       | T_LBRACKET EXPR T_RBRACKET { $$ = $2; }
       | FUNCTION_NAME T_LBRACKET EXPR T_RBRACKET {

        if (*$1 == "log"){
          $$ = new LogFunction ($3);
          }
        else if (*$1 == "sqrt"){
          $$ = new SqrtFunction ($3);
          }
        else if (*$1 == "exp"){
          $$ = new ExpFunction ($3);
          }
        }
       

/* TODO-6 : Add support log(x), by modifying the rule for FACTOR. */

/* TODO-7 : Extend support to other functions. Requires modifications here, and to FACTOR. */
FUNCTION_NAME : T_LOG { $$ = new std::string("log"); }
              | T_EXP { $$ = new std::string("exp"); }
              | T_SQRT { $$ = new std::string("sqrt"); }


//FUNCTION_DECLARATION :	T_TYPE_INT T_IDENTIFIER T_LBRACKET T_RBRACKET T_L_CURLY_BRACKET T_R_CURLY_BRACKET									{ $$ = new Functiondeclaration(*$2); }

//parameter_list					:	parameter_declaration				     							
//{ $$ = new std::vector<Declaration*>(1, $1); } |	parameter_list T_COMMA parameter_declaration 		{ $1->push_back($3); $$ = $1; }		| 	{ $$ = NULL; }

//parameter_declaration			:	TYPE declarator { $$ = new Declaration(*$1, new std::vector<Declarator*>(1, $2)); }




%%

const Expression *g_root; // Definition of variable (to match declaration earlier)

const Expression *parseAST()
{
  g_root=0;
  yyparse();
  return g_root;
}

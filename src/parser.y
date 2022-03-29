%code requires{
  #include "ast.hpp"
  #include <vector>
  #include <cassert>

  extern const Expression *g_root; 
  int yylex(void);
  void yyerror(const char *);
}


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
%token T_RETURN
%token T_SEMICOLON T_COMMA

%token T_TYPE_VOID T_TYPE_CHAR T_TYPE_INT T_TYPE_LONG T_TYPE_FLOAT T_TYPE_DOUBLE T_TYPE_SIGNED T_TYPE_UNSIGNED


%type <expr> EXPR TERM UNARY FACTOR LOGICOR LOGICAND BITWISEOR BITWISEXOR BITWISEAND LOGICEQ LOGICREL BITWISESHIFT RETURN PARAMETERLIST
%type <number> T_NUMBER
%type <string> T_VARIABLE T_LOG T_EXP T_SQRT FUNCTION_NAME T_IDENTIFIER T_TYPE_VOID T_TYPE_CHAR T_TYPE_INT T_TYPE_LONG T_TYPE_FLOAT T_TYPE_DOUBLE T_TYPE_SIGNED T_TYPE_UNSIGNED
%type <expr> FUNCTION_DECLARATION
//%type <declaration_node> declaration parameter_declaration
//%type <declaration_list_vector> declaration_list parameter_list




%start ROOT

%%


ROOT : FUNCTION_DECLARATION{ g_root = $1; }

FUNCTION_DECLARATION : T_TYPE_INT T_VARIABLE T_LBRACKET PARAMETERLIST T_RBRACKET T_L_CURLY_BRACKET RETURN T_R_CURLY_BRACKET { $$ = new Functiondeclaration(*$2, $7);} 

PARAMETERLIST: T_TYPE_INT T_VARIABLE { $$ = new Variable ( *$2 ); }
             | T_TYPE_INT T_VARIABLE T_COMMA PARAMETERLIST { $$ = new Variable( *$2 );}
             | {$$ = NULL;}


RETURN: T_RETURN LOGICOR  { $$ = new ReturnOp ($2);}
      | LOGICOR { $$ = $1; }


LOGICOR : LOGICOR T_OR LOGICAND { $$ = new OrOperator ( $1 , $3);} 
        | LOGICAND { $$ = $1; }

LOGICAND : LOGICAND T_AND BITWISEOR { $$ = new AndOperator ( $1 , $3);} 
         | BITWISEOR { $$ = $1; }


BITWISEOR : BITWISEOR T_BITWISEOR BITWISEXOR { $$ = new BitwiseOrOperator ( $1 , $3);} 
          | BITWISEXOR { $$ = $1; }


BITWISEXOR : BITWISEXOR T_BITWISEXOR BITWISEAND { $$ = new BitwiseXorOperator ( $1 , $3);} 
           | BITWISEAND { $$ = $1; }


BITWISEAND : BITWISEAND T_BITWISEAND LOGICEQ { $$ = new BitwiseAndOperator ( $1 , $3);} 
           | LOGICEQ { $$ = $1; }

LOGICEQ : LOGICREL T_EQUALS LOGICREL { $$ = new EqOperator ( $1 , $3);} 
        | LOGICREL T_NOTEQUALS LOGICREL { $$ = new NotEqOperator ($1, $3);}
        | LOGICREL { $$ = $1; }

LOGICREL :LOGICEQ T_GREATERTHAN BITWISESHIFT { $$ = new GreaterThanOperator ( $1 , $3);} 
        | LOGICEQ T_LESSTHAN BITWISESHIFT { $$ = new LessThanOperator ( $1 , $3);} 
        | LOGICEQ T_GREATERTHANEQUALS BITWISESHIFT { $$ = new GreaterThanEqOperator ( $1 , $3);} 
        | LOGICEQ T_LESSTHANEQUALS BITWISESHIFT { $$ = new LessThanEqOperator ( $1 , $3);} 
        | BITWISESHIFT { $$ = $1; }


BITWISESHIFT : BITWISESHIFT T_SHIFTLEFT EXPR { $$ = new LShiftOperator ( $1 , $3);} 
             | BITWISESHIFT T_SHIFTRIGHT EXPR { $$ = new RShiftOperator ($1, $3);}
             | EXPR { $$ = $1; }


EXPR : EXPR T_MINUS TERM   { $$ = new SubOperator ( $1 , $3); }
     | EXPR T_PLUS TERM   { $$ = new AddOperator ( $1 , $3); }
     | TERM { $$ = $1; }   

TERM : TERM T_TIMES UNARY           { $$ = new MulOperator ( $1, $3 ); }
     | TERM T_DIVIDE UNARY         { $$ = new DivOperator ( $1, $3 ); }
     | TERM T_MOD UNARY            { $$ = new ModOperator ( $1, $3 ); }
     | UNARY  { $$ = $1; }  

UNARY : T_MINUS FACTOR { $$ = new NegOperator ( $2 ); }
      | FACTOR T_INCREMENT { $$ = new IncrementOperator ( $1); }
      | FACTOR T_DECREMENT { $$ = new DecrementOperator ( $1); }
      | T_BITWISEFLIP FACTOR { $$ = new IncrementOperator ( $2); }
      | T_NOT FACTOR { $$ = new NotOperator ( $2); }
      | FACTOR         { $$ = $1; }


FACTOR : T_NUMBER     { $$ = new Number( $1 );  }
       | T_LBRACKET EXPR T_RBRACKET { $$ = $2; }
       | T_TYPE_INT T_VARIABLE { $$ = new Variable ( *$2 ); }
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
       
FUNCTION_NAME : T_LOG { $$ = new std::string("log"); }
              | T_EXP { $$ = new std::string("exp"); }
              | T_SQRT { $$ = new std::string("sqrt"); }

%%

const Expression *g_root; // Definition of variable (to match declaration earlier)

const Expression *parseAST()
{
  g_root=0;
  yyparse();
  return g_root;
}
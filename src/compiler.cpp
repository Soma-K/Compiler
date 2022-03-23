#include "ast.hpp"

#include <iomanip>
extern FILE *yyin;
extern FILE *yyout;
extern int yyparse(void);
const Expression *parseAST();

int main( int argc, char **argv ) {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;
    
    const Expression *ast=parseAST();
    ast->print(std::cout);
    std::cout<<std::endl;
    return 0;
}

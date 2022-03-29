#include "ast.hpp"

#include <iomanip>
extern FILE *yyin;
extern FILE *yyout;
extern int yyparse(void);
const Expression *parseAST();

int main( int argc, char **argv ) {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[1], "r" );
    else
        yyin = stdin;
    
    const Expression *ast=parseAST();
    std::ofstream output_file(argv[3]);
    ast->print(output_file);
    std::cout<<std::endl;
    return 0;
}

#include "../include/ast.hpp"

#include <iomanip>
extern FILE *yyin;
extern FILE *yyout;
extern int yyparse(void);


int main( int argc, char **argv ) {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[1], "r" );
    else
        yyin = stdin;
    std::ofstream output_file(argv[3]);
	Context context;
    const Node* root = parse();
    root->compile(output_file, context);
    
    return 0;
}
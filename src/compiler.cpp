#include "ast.hpp"
#include "../include/ast.hpp"
#include <iomanip>
#include <fstream>
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

    std::ofstream output_file(argv[3]);
    const Expression *ast=parseAST();
    
    ast->print(output_file);
    
    return 0;
}

// #include "../include/ast.hpp"

// #include <iomanip>
// extern FILE *yyin;
// extern FILE *yyout;
// extern int yyparse(void);


// int main( int argc, char **argv ) {
//     ++argv, --argc;  /* skip over program name */
//     if ( argc > 0 )
//         yyin = fopen( argv[1], "r" );
//     else
//         yyin = stdin;
//     std::ofstream output_file(argv[3]);
// 	Context context;
//     const Node* root = parse();
//     root->compile(output_file, context);
    
//     return 0;
// }
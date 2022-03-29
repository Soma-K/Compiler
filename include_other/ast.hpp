#ifndef ast_hpp
#define ast_hpp

#include "ast/ast_expression.hpp"
#include "ast/ast_primitives.hpp"
#include "ast/ast_operators.hpp"
#include "ast/ast_unary.hpp"
#include "ast/ast_functions.hpp"
#include "ast/ast_context.hpp"
#include "ast/ast_declaration.hpp"
#include "ast/ast_primitve.hpp"
#include "ast/ast_statement.hpp"

extern const Expression *parseAST();

#endif

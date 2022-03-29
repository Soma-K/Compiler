#ifndef ast_functions_hpp
#define ast_functions_hpp

#include "ast_expression.hpp"
#include <string>
#include <cmath>

class Functiondeclaration
    : public Expression
{
private:
    std::string id;
public:
    Functiondeclaration(const std::string &_id)
        : id(_id)
    {}

    const std::string getId() const
    { return id; }

    virtual void print(std::ostream &dst) const override
    {
        dst<<".global "<<id<<std::endl;
        dst<<id<<":"<<std::endl;
        
        dst<<"addiu   $sp,$sp,-8"<<std::endl;
        dst<<"sw      $fp,-4($sp)"<<std::endl;
        
        dst<<"move    $fp,$sp"<<std::endl;
       
        
    }

    virtual double evaluate(
        const std::map<std::string,double> &bindings
    ) const override
    {
        // TODO-B : Run bin/eval_expr with a variable binding to make sure you understand how this works.
        // If the binding does not exist, this will throw an error
        return bindings.at(id);
    }    
};

class Function
    : public Expression
{
private:
    ExpressionPtr arg;
protected:
    Function(ExpressionPtr _arg)
        : arg(_arg)
    {}
public:
    virtual ~Function()
    {
        delete arg;
    }

    virtual const char * getFunction() const =0;

    ExpressionPtr getArg() const
    { return arg; }

    virtual void print(std::ostream &dst) const override
    {
        dst<<getFunction()<<"( ";
        arg->print(dst);
        dst<<" )";
    }

    virtual double evaluate(
        const std::map<std::string,double> &bindings
    ) const override
    {
        // NOTE : This should be implemented by the inheriting function nodes, e.g. LogFunction
        // throw std::runtime_error("FunctionOperator::evaluate is not implemented.");
        double v = getArg()->evaluate(bindings);
        std::string f_name = getFunction();
        if (f_name == "log")
        {
            
            return log(v);
            
        }
        else if (f_name == "exp")
        {
            
            return exp(v);
        }
        else if (f_name == "sqrt")
        {
    
            return sqrt(v);
        }
        else {
            throw std::runtime_error("FunctionOperator::evaluate is not implemented.");
        }

    }
};

class LogFunction
    : public Function
{
public:
    LogFunction(ExpressionPtr _arg)
        : Function(_arg)
    {}

    virtual const char *getFunction() const
    { return "log"; }
    
    // TODO-E : Override evaluate, and implement it
};

class ExpFunction
    : public Function
{
public:
    ExpFunction(ExpressionPtr _arg)
        : Function(_arg)
    {}

    virtual const char *getFunction() const
    { return "exp"; }
};

class SqrtFunction
    : public Function
{
public:
    SqrtFunction(ExpressionPtr _arg)
        : Function(_arg)
    {}

    virtual const char *getFunction() const
    { return "sqrt"; }
};


#endif

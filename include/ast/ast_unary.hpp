#ifndef ast_unary_hpp
#define ast_unary_hpp

#include <string>
#include <iostream>

class Unary
    : public Expression
{
private:
    ExpressionPtr expr;
protected:
    Unary(const ExpressionPtr _expr)
        : expr(_expr)
    {}
public:
    virtual ~Unary()
    {
        delete expr;
    }

    virtual const char *getOpcode() const =0;

    ExpressionPtr getExpr() const
    { return expr; }

    virtual void print(std::ostream &dst) const override
    {
        dst << "( ";
        dst << getOpcode();
        dst << " ";
        expr->print(dst);
        dst << " )";
    }
};

class NegOperator
    : public Unary
{
public:
    NegOperator(const ExpressionPtr _expr)
        : Unary(_expr)
    {}

    virtual const char *getOpcode() const override
    { return "-"; }

    virtual double evaluate(
        const std::map<std::string, double> &bindings
    ) const override
    {
        double vl=-getExpr()->evaluate(bindings);
       
        return vl;
    }
};

class IncrementOperator
    : public Unary
{
public:
    IncrementOperator(const ExpressionPtr _expr)
        : Unary(_expr)
    {}

    virtual const char *getOpcode() const override
    { return "++"; }

    virtual double evaluate(
        const std::map<std::string, double> &bindings
    ) const override
    {
        double vl=(getExpr()+1)->evaluate(bindings);
        return vl;
    }
};

class DecrementOperator
    : public Unary
{
public:
    DecrementOperator(const ExpressionPtr _expr)
        : Unary(_expr)
    {}

    virtual const char *getOpcode() const override
    { return "--"; }

    virtual double evaluate(
        const std::map<std::string, double> &bindings
    ) const override
    {
        double vl=(getExpr()-1)->evaluate(bindings);
        return vl;
    }
};

class BitwiseFlipOperator
    : public Unary
{
public:
    BitwiseFlipOperator(const ExpressionPtr _expr)
        : Unary(_expr)
    {}

    virtual const char *getOpcode() const override
    { return "~"; }

   
};

class NotOperator
    : public Unary
{
public:
    NotOperator(const ExpressionPtr _expr)
        : Unary(_expr)
    {}

    virtual const char *getOpcode() const override
    { return "!"; }

    virtual double evaluate(
        const std::map<std::string, double> &bindings
    ) const override
    {
        double vl=!getExpr()->evaluate(bindings);
        return vl;
    }
};




#endif
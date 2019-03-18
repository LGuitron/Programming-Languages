#include <iostream>
#include <math.h>

// Define function pointer for functions receiving 2 doubles, and returning 1 double
typedef double (*func_pointer)(double,double);

// Function parameter as function pointer
double binary_operation(func_pointer funcp, double op1, double op2) 
{
    return funcp(op1, op2);
}


// Binary operation functions
double plus(double op1, double op2)
{
    return op1+op2;
}

double minus(double op1, double op2)
{
    return op1-op2;
}


double times(double op1, double op2)
{
    return op1*op2;
}

double divide(double op1, double op2)
{
    return op1/op2;
}



// Functors : Abstract base class                                                                                                                                                                                              
class BinaryFunction 
{
    public:
    BinaryFunction() {};
    virtual double operator() (double op1, double op2) = 0;
};

// Functors : Plus class                                                                                                                                                                                                   
class Plus : public BinaryFunction 
{
    public:
    Plus() {};
    virtual double operator() (double op1, double op2) { return op1+op2; }
};

// Functors : Times class                                                                                                                                                                                                      
class Times : public BinaryFunction {
public:
  Times() {};
  virtual double operator() (double op1, double op2) { return op1*op2; }
};

// Function for performing binary operations with functors
double binary_operation_functors(BinaryFunction* bin_func, double left, double right)
{
  return (*bin_func)(left, right);
}


// Function templates
template <class T>
double binary_operation_templates(T function, double op1, double op2)
{
    return function(op1, op2);
}



int main()
{
    // Array of binary functions
    int function_amount = 4;
    func_pointer functions[] = { plus, minus, times, divide};
    
    // FUNCTION POINTERS //
    std::cout<<"Function pointers"<<std::endl;
    for (int i = 0; i<function_amount; i++)
    {
        std::cout<<binary_operation(functions[i], 2, 4)<<std::endl;
    }
    
    // LAMBDA EXPRESSIONS//
    std::cout<<"Lambda expression"<<std::endl;
    std::cout<<binary_operation([](double op1, double op2){ return pow(op1, op2); }, 2, 4)<<std::endl;
    
    // FUNCTORS //
    std::cout<<"Functors"<<std::endl;
    BinaryFunction* p_plus  = new Plus();
    BinaryFunction* p_times = new Times();
    std::cout<<binary_operation_functors(p_plus, 2, 4)<<std::endl;
    std::cout<<binary_operation_functors(p_times, 2, 4)<<std::endl;
    delete p_plus;
    delete p_times;
    
    // FUCNTION TEMPLATES //
    std::cout<<"Function templates"<<std::endl;
    std::cout<<binary_operation_templates<func_pointer>(plus, 2, 4)<<std::endl;
    
    return 1;
}

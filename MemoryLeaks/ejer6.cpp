#include <iostream>

// Function modified to receive a global pointer, the returned address is also global
int* foo(int* value)
{
    int* val = value;
    return val;
}

int main()
{
    int a = 5;
    int * p;
    int b = 10;
    
    p = foo(&b);
    
    *p += 10;
    std::cout<<p<<std::endl;
}

#include<iostream>
using namespace std;

class Base
{
public:  
    int* p;

    Base(){ p = new int; }
    virtual ~Base(){ delete p; cout<<"dest_base"<<endl;} //Regla: colocar virtual en el destructor del padre
};

class Child : public Base
{
public:
    int* myP;
    Child(){myP = new int; }
    ~Child(){delete myP; cout<<"dest_child"<<endl;}
};

int main()
{
    Child* theChild = new Child();
    Base* polimorphicInstance = (Base*)theChild;
    delete polimorphicInstance;
}

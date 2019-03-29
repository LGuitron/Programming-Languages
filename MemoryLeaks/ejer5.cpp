#include<iostream>
using namespace std;
class Child
{
public:
    int* p;
    Child()
    {
        p = new int; 
    }
    
    // Copy constructor
    Child(const Child& other)
    {
        p = new int(*other.p);
    }
    ~Child()
    {
        delete p;         
    }    
};
int main()
{
    Child a;
    *(a.p) = 5;
    
    // Added copy constructor to avoid double free
    Child b = a;
    cout << *(b.p);
}

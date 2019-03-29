#include<iostream>
using namespace std;
class Object
{
public:
    int* value;
    Object(){value = new int(10);}
    ~Object()
    {
        delete value;
    }
};

int main()
{
    Object** array = new Object*[10];
    array[0] = new Object[10];
    array[1] = new Object;
 

    
    //for(int i=0; i<10; i++) //correcto
    //    delete [] array[i]; //correcto
    
    // Delete for pointers pointing to array
    delete [] array [0];
    
    // Delete for pointers pointing to single object
    delete array[1];
    
    
    delete array;
    return 1;
}

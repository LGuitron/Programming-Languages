#include<iostream>
#include<cstring>
using namespace std;

int main(int argc, char**argv)
{    
    char* string = new char[30];
    delete [] string;
    
    
    char* sub = new char[30];
    strcpy(sub, argv[1]); 
    delete [] sub;
    
    
    sub = new char[40];
    delete [] sub;                      // Delete before assigning again
    sub = new char[50];
    delete [] sub;
    
    
    
    
    char* three = new char[10];
    char* four = new char[10];
    //strcpy(three, "memory leak");
    strcpy(three, "memory le");         // Assign only string with length < 10 to make sure only the addresses corresponding to this pointer are accessed.
    //four = three;
    strcpy(four, three);                // Dont change the pointer, but only the value to which its pointing to
    delete [] three;
    delete [] four;
    
    return 1;
}

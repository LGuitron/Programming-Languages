#include <iostream>
#include <cstdlib>

void * declare_pointer(int size)
{
   void *p = malloc(size);
   return p;
}

int main()
{
    int p_sizes = 5;
    
    // Declare int pointer
    int* p1 = (int *) declare_pointer(p_sizes);
    p1[2] = 1;
    
    // Declare string pointer
    char* p2 = (char* ) declare_pointer(p_sizes);
    p2[0] = 'a';
    p2[1] = 'b';
    p2[2] = 'c';
    p2[3] = 'd';
    p2[4] = 'e';
    
    for (int i = 0; i<p_sizes; i++)
    {
        std::cout<<p1[i]<< ", ";
    }
    std::cout<<std::endl;
    for (int i = 0; i<p_sizes; i++)
    {
        std::cout<<p2[i]<< ", ";
    }
    std::cout<<std::endl;

    delete p1;
    delete p2;
    return 1;
}

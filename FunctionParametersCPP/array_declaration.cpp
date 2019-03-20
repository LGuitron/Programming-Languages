#include <iostream>
#include <cstdlib>

template <class T>
void reserve(T &pointer, int size)
{
   pointer = (T) malloc(size*sizeof(T)); 
}


int main()
{
    int p_sizes = 5;
    
    
    // Int example
    int *p1;
    reserve(p1, p_sizes);
    p1[2] = 1;
    for (int i = 0; i<p_sizes; i++)
    {
        std::cout<<p1[i]<< ", ";
    }
    
    std::cout<<std::endl;
    
    // Char example
    char *p2;
    reserve(p2, p_sizes);
    p2[3] = 'a';
    for (int i = 0; i<p_sizes; i++)
    {
        std::cout<<p2[i]<< ", ";
    }

    delete p1;
    delete p2;
}

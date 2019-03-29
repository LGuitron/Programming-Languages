#include <string>
#include <iostream>
#include <algorithm>

/*
El número 125874 y su doble 251748 contienen exactamente los mismos dígitos, pero en diferente orden. 
Encuentra el número positivo menor tal que su doble, triple, cuadruple y quintuple 
son números que contienen los mismos dígitos. (que no sea el cero)
*/


// Receive two numbers, and check that their digits match exactly
bool checkDigits(int num1, int num2)
{
    std::string num1_s = std::to_string(num1);
    std::string num2_s = std::to_string(num2);
    
    // If the length of the strings is not the same return false
    if (num1_s.length()!= num2_s.length())
        return false;
    
    // Check for a match for all the characters
    for (auto &char_num1 : num1_s)
    {
        int pos_num2 = num2_s.find(char_num1);    // Look for char in second number
        if(pos_num2 != std::string::npos)   
            num2_s.erase(pos_num2, 1);            // Remove this char from the second number
        else
            return false;
    }
        
    return true;
}

// Function for finding the smallest number that solves the problem
int findNumber()
{
    int n = 1;
    
    while (true)
    {
        // Checa double, triple, quadruple, and quintuple
        bool found_num = true;
        for (int i = 2; i<6; i++)
        {
            
            // The condition was not met, increase value of n, and keep trying
            // Lambda applied in the condition for checking double, triple, quadruple, and quintuple
            if (!checkDigits(n, [&](int num){ return num*i;}(n)))
            {
                n++;
                found_num = false;
                break;
            }
        }
        // Return smallest number that satisfies the rule
        if (found_num)
            return n;
    }
    
}


int main()
{
    std::cout<<findNumber()<<std::endl;
    return 1;
}

main = print (largest_palindrome 3)

-- function for finding the largest palindrome number resulting from multiplying two integers of n digits
largest_palindrome :: Int -> [Int]
largest_palindrome n = largest_palindrome_recursive (10^n - 1) (10^n - 1) (10^n - 1) (10^(n-1)) ([-1, -1, -1])



-- function for finding smallest palindrome recursively
---------------
-- Parameters:
---------------
-- num1            : first n digit factor to be tested
-- num2            : second n digit factor to be tested
-- largest_factor  : largest_factor that can be used (largest n digit number)
-- smallest_factor : smallest_factor that can be used (smallest n digit number)
-- max_palindrome  : largest palindrome found so far 
---------------
-- Returns:
---------------
-- max_prod        : Array containing [factor1, factor2, palindrome_product]
largest_palindrome_recursive :: Int -> Int -> Int -> Int -> [Int] -> [Int]
largest_palindrome_recursive = \num1 -> \num2 -> \largest_factor -> \smallest_factor-> \max_palindrome ->
    
    -- Return result if both num1 and num2 reach the value of the smallest factor
    if num1 == smallest_factor && num2 == smallest_factor
       then max_palindrome

    -- current product is palindrome, and it is greater than the best found so far
       else if is_palindrome (show (num1*num2)) && num1*num2 > max_palindrome!!2
                
                -- call function recursively and update factors to be tested factors
                then if num1 > smallest_factor 
                        then largest_palindrome_recursive (num1-1) num2 largest_factor smallest_factor ([num1, num2, num1*num2])
                        else largest_palindrome_recursive largest_factor (num2-1) largest_factor smallest_factor ([num1, num2, num1*num2])
    
                -- test for other products (not palindrome, or not large enough)
                else if num1 > smallest_factor 
                        then largest_palindrome_recursive (num1-1) num2 largest_factor smallest_factor max_palindrome
                        else largest_palindrome_recursive largest_factor (num2-1) largest_factor smallest_factor max_palindrome


-- function to check if a given number x is palindrome
is_palindrome :: String -> Bool
is_palindrome x =
    
    -- one character strings are always palindromes
    if length x == 1
       then True

        -- check if first and last characters are equal
       else if head x == last x
            then
            
            -- two character strings are palindromes if both chars are the same
            if length x == 2 
               then True

               -- three or more characters call palindrome function recursively removing first and last elements
               else is_palindrome (init (tail x))

        -- Otherwise string is not palindrome
        else
            False

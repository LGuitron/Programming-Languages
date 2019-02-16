main = print (find_prime 10001)

-- function for finding the nth prime number
-- [2, 3] are added initially at the list so that the primes to be tested increase by 2 each time
find_prime :: Int -> Int
find_prime n = find_prime_recursive n 2 5 ([2, 3])



-- function to calculate smallest number divisible using tail recursion
-- Parameters:
--           n : index of the prime to be found
--           x : number of primes found already
-- test_number : number currently being tested for primality
--      p_list : list of primes found so far
find_prime_recursive :: Int -> Int -> Int -> [Int] -> Int
find_prime_recursive  = 

   \n -> \x -> \test_number -> \p_list -> 
   
    -- Prime number found, return if its the nth prime, or continue and add it to the list of current primes
    if check_primality test_number p_list                                                       
       then if x+1 == n
                then test_number                                                                --return the test number (it is the nth prime)
                else find_prime_recursive n (x+1) (test_number+2) (p_list ++ [test_number])         
    
    -- Tested number was not prime, make test with another one
    else
        find_prime_recursive n x (test_number+2) p_list 
        
    


-- function for checking if a given number is coprime with all of the numbers passed in the current prime list
-- Return: True if x is prime
check_primality :: Int -> [Int] -> Bool
check_primality = 
    \x -> \p_list->
    
    minimum
            (zipWith 
            (mod) 
            (take (length ((p_list))) (repeat x)) 
            (p_list)
            )
    > 0

    
-- function that returns a shorter list containing only the values of numbers <= sqrt x 
reduced_p_list :: Int -> [Int] -> [Int] -> [Int]
reduced_p_list = 
    \x -> \p_list-> \small_list ->
    
    if length (p_list) == 0 then small_list
    
    else if head p_list <= ceiling (sqrt (fromIntegral x))
       then reduced_p_list x (tail p_list) (small_list ++ [head p_list])
       else small_list

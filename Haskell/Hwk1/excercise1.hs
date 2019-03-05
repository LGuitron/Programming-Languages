-- main function receives value of n calculating lcm between numbers 1 - n
main = print (least_multiple 4)


-- function to calculate smallest number divisible by all numbers 1 - n
least_multiple n = least_multiple_recursive n 1 1


-- function to calculate smallest number divisible using tail recursion
-- Parameters:
--      n : last value
--      x : current divisor (ranges from 1 to n)
-- result : current smallest number calculated so far
least_multiple_recursive  = 

   \n -> \x -> \result -> 
    
    -- tail recursive call passing value of calculated lcm so far
    if x <= n then least_multiple_recursive n (x+1) (lcm x result)
    
    -- when x surpasses the value of n return the result
    else result

main = print (least_multiple 10)


-- function to calculate lcm of numbers between 1 - n
least_multiple 1 = 1
least_multiple n = lcm n (least_multiple(n-1))




--least_multiple n = 
--                    take 5 [ lcm 5 (lcm(5-i) (5-i)) | i <- [1..4]]
--list_least_multiple n = [ lcm n (n-i) | i <- [1..n]]

main = print(secant_method (\x -> x^3 + 2*x^2 +3*x -7) (-1) (1) 0.00001)

secant_method :: (Floating a, Ord a) => (a -> a) -> a -> a -> a -> a
secant_method f x0 x1 eps

   | rootDifference < eps = x2
   | otherwise = secant_method f x1 x2 eps
   where
       x2 = (x0 * f(x1) - x1 * f(x0))/(f(x1) - f(x0))
       rootDifference = abs(x2-x1)

main = print(secant_method (\x -> x^3 + 2*x^2 +3*x -7) (-1) (1) 0.00001)

secant_method :: (Float -> Float) -> Float -> Float -> Float -> Float
secant_method f x0 x1 eps = 
    
    -- Calculate new value of x and compare epsilon values 
    if abs (((x0 * f(x1) - x1 * f(x0))/(f(x1) - f(x0))) - x1) < eps
        
        -- return the root
        then (x0 * f(x1) - x1 * f(x0))/(f(x1) - f(x0))

        -- update and continue
        else secant_method f x1 ((x0 * f(x1) - x1 * f(x0))/(f(x1) - f(x0))) eps

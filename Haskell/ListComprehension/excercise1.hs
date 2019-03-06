main = print (head [x | x <- [1..1000000], func x 1 10 == True])

func y min max
    | length list == max = True
    | otherwise          = False
    where
        list = [x | x <- [min..max], mod y x ==0]

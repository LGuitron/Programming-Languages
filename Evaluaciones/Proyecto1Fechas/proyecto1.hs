main = print (lista_de_fechas_siguientes ([[31, 12, 2010],[12, 9, 2014],[28, 2, 2016]]))

-- Map next day function to list of dates
lista_de_fechas_siguientes :: [[Int]] -> [[Int]]
lista_de_fechas_siguientes lista_fechas =
    map dia_siguiente lista_fechas

    
-- Calculate next day of a given date on gregorian calendar
dia_siguiente :: [Int] -> [Int]
dia_siguiente fecha =
    
    --fecha
    -- Add day if month is not over yet
    if head fecha <  duracion_mes (tail fecha)
       then  [1 + head fecha] ++ (tail fecha)
       
       -- Add month if year is not over yet
       else if head (tail fecha) < 12
                then [1, 1 + head (tail fecha)] ++ [last fecha]
                
                -- Add year
                else [1, 1] ++ [1 + last fecha]

    
    
-- Return the duration in days of the current month
duracion_mes :: [Int] -> Int
duracion_mes mes_anio=
    
    -- Calculations for february
    if head mes_anio == 2

       -- Check if year is leap
       -- rule1 : year multiple of 4
       then if mod (head (tail mes_anio)) 4 == 0
                
                -- years multiples of 100
                then if mod (head (tail mes_anio)) 100 == 0
                
                        --  rule 2: multiples of 400 are leap, multiples of 100 only are NOT leap
                        then if mod (head (tail mes_anio)) 400 == 0
                                then 29
                                else 28

                        -- multiple of 4, not multiple of 100
                        else 29

                -- not multiple of 4
                else 28

        -- Calculations for other months
        else if head mes_anio <= 7
                then 30 + mod (head mes_anio) 2    -- January : July
                else 30 + mod (1 + head mes_anio) 2    -- August : December        

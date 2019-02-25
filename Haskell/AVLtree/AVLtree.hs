main = print (insertTree (-15)(insertTree (-5)(insertTree (-10)(insertTree 25(insertTree 30(insertTree 0(insertTree 5(insertTree 10 (insertTree 15 (insertTree 20 EmptyTree))))))))))

-- Binary tree structure also stures balancing factor b
data Tree a = EmptyTree | Node a (Tree a)(Tree a) deriving (Show, Read, Eq)


insertTree x EmptyTree = Node x (EmptyTree)(EmptyTree)
insertTree x (Node y left right)
           | x == y  = Node x left right 
           | x < y   = rebalance(Node y (insertTree x left) right) 
           | x > y   = rebalance(Node y left (insertTree x right)) 

           
-- Calculate balance factor given left and right children
balanceFactor EmptyTree             = 0
balanceFactor (Node y left right)   = depth(right) - depth (left)


-- Balance tree after insertion
rebalance (Node y left right)
            
            | balanceFactor(Node y left right) == -2 && balanceFactor(left)  <=  0 = balanceLL(Node y left right)  
            | balanceFactor(Node y left right) == -2 && balanceFactor(left)  ==  1 = balanceLR(Node y left right)  
            | balanceFactor(Node y left right) ==  2 && balanceFactor(right) == -1 = balanceRL(Node y left right)  
            | balanceFactor(Node y left right) ==  2 && balanceFactor(right) >=  0 = balanceRR(Node y left right)  

            -- Rebalancing not necessary
            | abs (balanceFactor(Node y left right)) < 2 = (Node y left right)  

-- Balance functions
balanceLL (Node y (Node ly lleft lright) right) = (Node ly lleft (Node y lright right))
balanceLR (Node y (Node ly lleft (Node lry lrleft lrright)) right) = (Node lry (Node ly lleft lrleft) (Node y lrright right))
balanceRL (Node y left (Node ry (Node rly rlleft rlright) rright)) = (Node rly (Node y left rlleft) (Node ry rlright rright)) 
balanceRR (Node y left (Node ry rleft rright)) = (Node ry (Node y left rleft) rright)



--  Function for calculating depth for each tree
depth EmptyTree = 0
depth (Node y left right) = (max (depth (left)) (depth (right))) + 1

                
-- Functions for getting left child, right child, value, and balancing factor of a given tree
get_left_child  (Node y left right ) = left
get_right_child (Node y left right ) = right
get_value (Node y left right )       = y

-- Inserting Test
main = print (insertTree (-15)(insertTree (-5)(insertTree (-10)(insertTree 25(insertTree 30(insertTree 0(insertTree 5(insertTree 10 (insertTree 15 (insertTree 20 EmptyTree))))))))))

-- Deleting Test
-- main = print(delete (insertTree 8(insertTree 9(insertTree 10(insertTree 11 EmptyTree)))) 10)

-- Binary tree structure also stures balancing factor b
data Tree a = EmptyTree | Node a (Tree a)(Tree a) deriving (Show, Read, Eq)

-- Insert operation for AVL tree
insertTree x EmptyTree = Node x (EmptyTree)(EmptyTree)
insertTree x (Node y left right)
           | x == y  = Node x left right 
           | x < y   = rebalance(Node y (insertTree x left) right) 
           | x > y   = rebalance(Node y left (insertTree x right)) 

-- Balance AVL Tree after insertion
rebalance (Node y left right)
            
            | balanceFactor(Node y left right) == -2 && balanceFactor(left)  <=  0 = balanceLL(Node y left right)  
            | balanceFactor(Node y left right) == -2 && balanceFactor(left)  ==  1 = balanceLR(Node y left right)  
            | balanceFactor(Node y left right) ==  2 && balanceFactor(right) == -1 = balanceRL(Node y left right)  
            | balanceFactor(Node y left right) ==  2 && balanceFactor(right) >=  0 = balanceRR(Node y left right)  

            -- Rebalancing not necessary
            | abs (balanceFactor(Node y left right)) < 2 = (Node y left right)  
           
           

-- Delete operation for AVL tree
delete EmptyTree del = EmptyTree
delete (Node y EmptyTree EmptyTree) del = if y == del then EmptyTree else (Node y EmptyTree EmptyTree)
delete (Node y left EmptyTree) del = if y == del then left else (Node y left EmptyTree)
delete (Node y EmptyTree right) del = if y == del then right else (Node y EmptyTree right)
delete (Node y left right) del
    | y == del                                                                           = rebalance(Node mright left dmin)
    | y > del && abs (balanceFactorChild dleft right) < 2                                = (Node y dleft right)
    | y < del && abs (balanceFactorChild left dright) < 2                                = (Node y left dright)
    | y > del && (balanceFactorChild (get_left_child right) (get_right_child right)) < 0 = balanceRR (Node y dleft right) 
    | y < del && (balanceFactorChild (get_left_child left) (get_right_child left)) > 0   = balanceLL (Node y left dright)
    | y > del                                                                            = balanceRL (Node y dleft right)
    | y < del                                                                            = balanceLR (Node y left dright)
        where dmin   = delete right mright
              dleft  = delete left del
              dright = delete right del
              mright = head(read_inorder(right))

              
--  Function for calculating depth for each tree
depth EmptyTree = 0
depth (Node y left right) = (max (depth (left)) (depth (right))) + 1              

-- Calculate balance factor given left and right children
balanceFactor EmptyTree             = 0
balanceFactor (Node y left right)   = depth(right) - depth (left)

-- Calculate balance factor receiving two tree (left , right)
balanceFactorChild left right = (depth left) - (depth right)

-- Balance functions
balanceLL (Node y (Node ly lleft lright) right) = (Node ly lleft (Node y lright right))
balanceLR (Node y (Node ly lleft (Node lry lrleft lrright)) right) = (Node lry (Node ly lleft lrleft) (Node y lrright right))
balanceRL (Node y left (Node ry (Node rly rlleft rlright) rright)) = (Node rly (Node y left rlleft) (Node ry rlright rright)) 
balanceRR (Node y left (Node ry rleft rright)) = (Node ry (Node y left rleft) rright)

-- Tree inorder printing
read_inorder EmptyTree = []
read_inorder (Node y left right) = read_inorder(left) ++ [y] ++ read_inorder(right)

-- Get children of a given node
get_left_child  (Node y left right ) = left
get_right_child (Node y left right ) = right

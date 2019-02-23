--      Tree used
--           5
--        /     \
--       4       7
--      / \     /
--     2   3   6
--

main = print (read_inorder(insertTree 6(insertTree 3(insertTree 2 (insertTree 7 (insertTree 4 (insertTree 5 EmptyTree)))))))
data Tree a = EmptyTree | Node a (Tree a)(Tree a) deriving (Show, Read, Eq)

insertTree x EmptyTree = Node x (EmptyTree)(EmptyTree)
insertTree x (Node y left right)
           | x == y = Node x left right
           | x < y  = Node y (insertTree x left) right
           | x > y  = Node y left (insertTree x right)
           

read_inorder (Node y left right) =

    if left == EmptyTree
    
       -- No left tree
       then if right == EmptyTree
                then [y]
                else [y] ++ (read_inorder right)
        
       -- Has left tree
       else if right == EmptyTree
                then (read_inorder left) ++ [y]
                else (read_inorder left) ++ [y] ++ (read_inorder right)

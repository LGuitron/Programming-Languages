--      Tree used
--           5
--        /     \
--       3       7
--      / \     /
--     2   4   6
--

main = print (read_inorder(insertTree 6(insertTree 4(insertTree 2 (insertTree 7 (insertTree 3 (insertTree 5 EmptyTree)))))))
data Tree a = EmptyTree | Node a (Tree a)(Tree a) deriving (Show, Read, Eq)

insertTree x EmptyTree = Node x (EmptyTree)(EmptyTree)
insertTree x (Node y left right)
           | x == y = Node x left right
           | x < y  = Node y (insertTree x left) right
           | x > y  = Node y left (insertTree x right)
           

           
           
read_inorder EmptyTree = []
read_inorder (Node y left right) = read_inorder(left) ++ [y] ++ read_inorder(right)

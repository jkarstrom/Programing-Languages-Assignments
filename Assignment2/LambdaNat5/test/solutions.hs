-- takes an element and a list and returns 1 if the element is in the list
-- and 0 if the element is not in the list.
member :: Int -> [Int] -> Int
member a [] = 0
member a x:xs = if a == x then 1 else member a xs

remove :: Int -> [Int] -> [Int]
remove a [] = []
remove a x:xs = if a == x then xs else x : remove a xs

sum :: [Int] -> Int
sum [] = 0
sum (x:xs) = x + sum xs

prod :: [Int] -> Int
prod [] = 1
prod (x:xs) = x * prod xs

plus_two :: Int -> Int
plus_two (x) = x + 2

-- takes a function from lists to lists and takes a list and applies the function to each element.
map :: (Int -> Int) -> [Int] -> [Int]
map fun [] = []
map fun x:xs = (fun x) : map xs

insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x y:ys = if x <= y then x:y:ys else y: insert x ys

--takes an input-list of integers and calls upon insert recursively to sort the input-list. this is literally just insertion sort
sort :: [Int] -> [Int]
sort [] = []
sort [x] = [x]
sort x:xs = insert x (sort xs)

main :: IO ()
main = do
  print $ member (1 [2,3,1])
  --print $ remove (2 [1,2,3,1,2,3])
  print $ sum ([1,2,3,4])
  --print $ prod ([1,2,3,4])
  --print $ plus_two (2)
  --print $ map (plus_two [1,2,3,4])
  --print $ sort ([1,2,3,1,2,3])

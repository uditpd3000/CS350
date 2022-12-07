import Data.List as List

-- Ques 1

takeAlternate 0 _ = []                                            -- If n == 0, return empty list irrespective of input list
takeAlternate n [] = []                                           -- If list is empty, return empty list
takeAlternate n (x:xs) = x: (takeAlternate (n-1) (List.tail xs))  -- Take first element, remove the second one and again repeat

-- Ques 2

myLast [] = error "empty list"                                    -- If input is empty list, raise an exception
myLast inputlist = inputlist !! (List.length(inputlist)-1)        -- Otherwise return element at last index

-- Ques 3

mergeWithDups [] [] = []                                          -- Both are empty, return empty list 
mergeWithDups [] (x:xs) = (x:xs)                                  -- One of them is empty, return other list
mergeWithDups (y:ys) [] = (y:ys)
mergeWithDups (x:xs) (y:ys) = if (x==y)                           -- If both element are equal, take once and move to next element of both lists
    then x: mergeWithDups xs ys
    else if(x>y)
        then y: mergeWithDups (x:xs) ys                           -- else take the smaller one and move to the next element of this list 
        else x: mergeWithDups xs (y:ys)                           -- This function will provide merged list with no duplicates if there is no duplicates in input list

dropdups l | (length l < 2) = l                                   -- This function will drop the duplicates from a sorted list
           | (length l >=2) = if (x /= head xs)                   -- If first element is not equal to second one, then take first element into output
               then x: dropdups xs                                -- otherwise drop it
               else dropdups xs where
               (x:xs) = l 

mergeLists a b = dropdups (mergeWithDups a b)                     -- This function makes use of mergeWithDups and dropdups to provide merged list with no duplicates if there are duplicates in input list

-- Ques 4a

myzip [] [] = []
myzip (x:xs) (y:ys) = (x,y): myzip xs ys                          -- Simply add (x,y) to the tuple and call zip xs ys

-- 4b

myzipwith f [] [] = []
myzipwith f (x:xs) (y:ys) = (f x y): myzipwith f xs ys            -- Applies f on x,y and add it to the list

-- Ques 5

foldR foo start [] = start                                        -- For empty list, return the start value
foldR foo start (x:xs) = foo x newstart                           -- otherwise call foldR recursively taking newstart as result of foldR till that element
                            where newstart = foldR foo start xs

myMap foo [] = []
myMap foo (x:xs) = foo x: foldR (\el els-> (foo el): els) [] xs      -- For building a map using foldr, we will use a empty list as start and then recursively call foldr for tail of the list 
                                                                     -- which eventually ends up with empty list which we can handle and then we will start appending the (foo element) to the start
                                                                     -- while returning from the previous recursive call
-- Ques 6a
 
nums n = n: nums (n+1)                                                        -- List of numbers from n to inf  

list_comp = [x| x <- nums 1, x `mod` 2 == 0 || x `mod` 3 == 0 || x `mod` 5 == 0 ] -- List comprehension

-- Ques 6b

func(x:xs) = if (x `mod` 2 ==0 || x `mod` 3 == 0 || x `mod` 5 == 0)  -- Using self refrential stream
    then x:(func xs)                                                 -- if x is multiple of 2,3 or 5 then add it else move to next element
    else func xs
list_stream = func (nums 1)

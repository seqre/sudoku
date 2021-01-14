module Sudoku.Data.Indices
where

boxFormIndices :: [[Int]]
boxFormIndices = map boxIndices keyIndices
    where
        keyIndices = [0,3,6,27,30,33,54,57,60]
        boxIndices i = [x + y | x <- [i, i+9, i+18], y <- [0..2]]

rowFormIndices :: [[Int]]
rowFormIndices = map (\x -> [x..x+8]) [0,9..72]

colFormIndices :: [[Int]]
colFormIndices = map (\x -> [x,x+9..x+(9*8)]) [0..8]

getRowIndices :: Int -> [Int]
getRowIndices n = let modded = n - mod n 9 in [modded..modded+8]

getColIndices :: Int -> [Int]
getColIndices n = let modded = mod n 9 in [modded,modded+9..modded+(9*8)]

getBoxIndices :: Int -> [Int]
getBoxIndices n = head . filter (elem n) $ boxFormIndices
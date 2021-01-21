module Sudoku.Data.Indices
where

import Utils.List

boxFormIndices :: [[Int]]
boxFormIndices = map boxIndices keyIndices
    where
        keyIndices   = [x + y | x <- [0, 27, 54], y <- [0, 3, 6]]
        boxIndices i = [x + y | x <- [i, i + 9, i + 18], y <- [0..2]]

rowFormIndices :: [[Int]]
rowFormIndices = map (\x -> [x .. x + 8]) [0, 9 .. 72]

colFormIndices :: [[Int]]
colFormIndices = map (\x -> [x, x + 9 .. x + (9 * 8)]) [0..8]

allFormIndices :: [[Int]]
allFormIndices = boxFormIndices ++ rowFormIndices ++ colFormIndices

getRowIndices :: Int -> [Int]
getRowIndices n = let modded = n - mod n 9 in [modded..modded+8]

getColIndices :: Int -> [Int]
getColIndices n = let modded = mod n 9 in [modded, modded + 9 .. modded + (9 * 8)]

getBoxIndices :: Int -> [Int]
getBoxIndices n = head . filter (elem n) $ boxFormIndices

getDependentIndices :: Int -> [Int]
getDependentIndices n = sort . nub $ getBoxIndices n ++ getColIndices n ++ getRowIndices n
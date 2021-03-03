module Sudoku.Data.Indices
where

import Sudoku.Data.Types

import Data.List


boxFormIndices :: [[Coord]]
boxFormIndices = map boxIndices keyIndices
    where
        keyIndices        = [(x, y) | x <- [0, 3, 6], y <- [0, 3, 6]]
        boxIndices (a, b) = [(x, y) | x <- [a .. a + 2], y <- [b .. b + 2]]

rowFormIndices :: [[Coord]]
rowFormIndices = [[(i, y) | y <- [0..8]] | i <- [0..8]]

colFormIndices :: [[Coord]]
colFormIndices = [[(x, i) | x <- [0..8]] | i <- [0..8]]

allFormIndices :: [[Coord]]
allFormIndices = boxFormIndices ++ rowFormIndices ++ colFormIndices

getRowIndices :: Coord -> [Coord]
getRowIndices (a, b) = [(a, y) | y <- [0..8], y /= b]

getColIndices :: Coord -> [Coord]
getColIndices (a, b) = [(x, b) | x <- [0..8], x /= a]

-- TODO: Make faster
getBoxIndices :: Coord -> [Coord]
getBoxIndices coord = head . filter (elem coord) $ boxFormIndices

getDependentIndices :: Coord -> [Coord]
getDependentIndices coord = sort . nub $ getBoxIndices coord ++ getColIndices coord ++ getRowIndices coord

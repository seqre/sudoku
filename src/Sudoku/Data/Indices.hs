module Sudoku.Data.Indices
where

import Sudoku.Data.Types
import Data.List

-- |The 'boxFormIndices' function returns list of lists of indices in box form
boxFormIndices :: [[Coord]]
boxFormIndices = map boxIndices keyIndices
    where
        keyIndices        = [(x, y) | x <- [0, 3, 6], y <- [0, 3, 6]]
        boxIndices (a, b) = [(x, y) | x <- [a .. a + 2], y <- [b .. b + 2]]

-- |The 'rowFormIndices' function returns list of lists of indices in row form
rowFormIndices :: [[Coord]]
rowFormIndices = [[(i, y) | y <- [0..8]] | i <- [0..8]]

-- |The 'colFormIndices' function returns list of lists of indices in column form
colFormIndices :: [[Coord]]
colFormIndices = [[(x, i) | x <- [0..8]] | i <- [0..8]]

-- |The 'allFormIndices' function returns list of lists of indices in all forms
allFormIndices :: [[Coord]]
allFormIndices = boxFormIndices ++ rowFormIndices ++ colFormIndices

-- |The 'getRowIndices' function returns list of indices of row form for specified index
getRowIndices :: Coord -> [Coord]
getRowIndices (a, b) = [(a, y) | y <- [0..8], y /= b]

-- |The 'getColIndices' function returns list of indices of column form for specified index
getColIndices :: Coord -> [Coord]
getColIndices (a, b) = [(x, b) | x <- [0..8], x /= a]

-- TODO: Make faster
-- |The 'getBoxIndices' function returns list of indices of box form for specified index
getBoxIndices :: Coord -> [Coord]
getBoxIndices coord = head . filter (elem coord) $ boxFormIndices

-- |The 'getDependentIndices' function returns indices that depends on that index
getDependentIndices :: Coord -> [Coord]
getDependentIndices coord = sort . nub $ getBoxIndices coord ++ getColIndices coord ++ getRowIndices coord

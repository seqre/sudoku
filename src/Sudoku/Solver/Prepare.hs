module Sudoku.Solver.Prepare
( prepare
) where

import Data.List (nub, (\\))
import Debug.Trace (trace)

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku

prepare :: InnerSudoku -> InnerSudoku
prepare = flip innerPrepare 0

innerPrepare :: InnerSudoku -> Int -> InnerSudoku
innerPrepare sudoku@(IS cells) n | n == 81 = sudoku
                                 | isCV cell = innerPrepare sudoku (n + 1)
                                 | otherwise = innerPrepare processed (n + 1)
    where
        cell = cells !! n
        processed = processCell sudoku n

processCell :: InnerSudoku -> Int -> InnerSudoku
processCell sudoku@(IS cells) n = IS (prev ++ [CP newVals] ++ next)
    where
        boxIndices = getBoxIndices n
        rowIndices = getRowIndices n
        colIndices = getColIndices n
        indices = nub (boxIndices ++ rowIndices ++ colIndices)
        vals = getVals sudoku indices
        newVals = [1..9] \\ vals
        (prev, _ : next) = splitAt n cells
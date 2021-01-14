module Sudoku.Solver.PenAndPaper.Prepare
( prepare
) where

import Data.List (nub, (\\))

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku

prepare :: InnerSudoku -> InnerSudoku
prepare = flip innerPrepare 0

innerPrepare :: InnerSudoku -> Int -> InnerSudoku
innerPrepare sudoku@(IS cells) n | n == 81 = sudoku
                                 | isCV cell = innerPrepare sudoku (n+1)
                                 | otherwise = processCell sudoku n
    where
        cell = cells !! n

processCell :: InnerSudoku -> Int -> InnerSudoku
processCell sudoku@(IS cells) n = newSudoku
    where
        boxIndices = getBoxIndices n
        rowIndices = getRowIndices n
        colIndices = getColIndices n
        indices = nub (boxIndices ++ rowIndices ++ colIndices)
        vals = getVals sudoku indices
        newVals = [1..9] \\ vals
        newSudoku = replaceAt sudoku n (CP newVals)
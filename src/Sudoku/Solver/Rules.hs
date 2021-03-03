module Sudoku.Solver.Rules
( checkIndex
) where

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku

checkIndex :: InnerSudoku -> Int -> Bool
checkIndex sudoku n = checkRowFromIndex sudoku n && checkColFromIndex sudoku n && checkBoxFromIndex sudoku n

checkRowFromIndex :: InnerSudoku -> Int -> Bool
checkRowFromIndex sudoku = checkDuplicates . getVals sudoku . getRowIndices

checkColFromIndex :: InnerSudoku -> Int -> Bool
checkColFromIndex sudoku = checkDuplicates . getVals sudoku . getColIndices

checkBoxFromIndex :: InnerSudoku -> Int -> Bool
checkBoxFromIndex sudoku = checkDuplicates . getVals sudoku . getBoxIndices

checkDuplicates :: [Int] -> Bool
checkDuplicates []     = True
checkDuplicates (l:ls) = notElem l ls && checkDuplicates ls

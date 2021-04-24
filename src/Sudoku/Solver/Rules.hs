module Sudoku.Solver.Rules
( checkIndex
) where

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types

checkIndex :: InnerSudoku -> Coord -> Bool
checkIndex sudoku n = checkRowFromIndex sudoku n && checkColFromIndex sudoku n && checkBoxFromIndex sudoku n

checkRowFromIndex :: InnerSudoku -> Coord -> Bool
checkRowFromIndex sudoku = checkDuplicates . getVals sudoku . getRowIndices

checkColFromIndex :: InnerSudoku -> Coord -> Bool
checkColFromIndex sudoku = checkDuplicates . getVals sudoku . getColIndices

checkBoxFromIndex :: InnerSudoku -> Coord -> Bool
checkBoxFromIndex sudoku = checkDuplicates . getVals sudoku . getBoxIndices

checkDuplicates :: [Int] -> Bool
checkDuplicates []     = True
checkDuplicates (l:ls) = notElem l ls && checkDuplicates ls

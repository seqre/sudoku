module Sudoku.Solver.Rules
( checkIndex
) where

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types

-- |The 'checkIndex' function checks whether the value in specified cell is proper according to sudoku rules
checkIndex :: InnerSudoku -> Coord -> Bool
checkIndex sudoku n = checkRowFromIndex sudoku n && checkColFromIndex sudoku n && checkBoxFromIndex sudoku n

-- |The 'checkRowFromIndex' function checks whether the value in specified cell is proper according to sudoku rules in the row
checkRowFromIndex :: InnerSudoku -> Coord -> Bool
checkRowFromIndex sudoku = checkDuplicates . getVals sudoku . getRowIndices

-- |The 'checkColFromIndex' function checks whether the value in specified cell is proper according to sudoku rules in the column
checkColFromIndex :: InnerSudoku -> Coord -> Bool
checkColFromIndex sudoku = checkDuplicates . getVals sudoku . getColIndices

-- |The 'checkBoxFromIndex' function checks whether the value in specified cell is proper according to sudoku rules in the box
checkBoxFromIndex :: InnerSudoku -> Coord -> Bool
checkBoxFromIndex sudoku = checkDuplicates . getVals sudoku . getBoxIndices

-- |The 'checkDuplicates' function checks if the list consists of only unique values
checkDuplicates :: [Int] -> Bool
checkDuplicates []     = True
checkDuplicates (l:ls) = notElem l ls && checkDuplicates ls

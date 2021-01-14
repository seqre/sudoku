module Sudoku.Sudoku
( solve
) where

import Sudoku.Data.InnerSudoku
import Sudoku.Data.InputSudoku
import Sudoku.Solver.PenAndPaper.Prepare
import Sudoku.Solver.Bruteforce 
import Utils.List

solve :: String -> String
solve input = maybe defaultValue showingFunc sudoku
    where
        defaultValue = "No solution"
        showingFunc  = show . getAllVals
        sudoku       = solver . prepare . fromInput . readFromString $ input
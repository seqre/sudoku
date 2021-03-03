module Sudoku.Sudoku
( solve
) where

import Data.List
import Data.Maybe

import Sudoku.Data.InnerSudoku
import Sudoku.Data.InputSudoku
import Sudoku.Solver.Prepare
import qualified Sudoku.Solver.PenAndPaper.Solver as PAP
import qualified Sudoku.Solver.Auto as A
import qualified Sudoku.Solver.Bruteforce as B

dispatch :: [(String, InnerSudoku -> Maybe InnerSudoku)]
dispatch = [
    ("auto", A.solver),
    ("bruteforce", B.solver)
    ]

solve :: String -> String -> String
solve solverString input = if isJust solver
                           then maybe defaultValue showingFunc $ fromJust solver sudoku
                           else "Such solver does not exist."
    where
        solver       = lookup solverString dispatch
        defaultValue = "No solution"
        showingFunc  = show . getAllVals
        sudoku       = prepare . fromInput . readFromString $ input

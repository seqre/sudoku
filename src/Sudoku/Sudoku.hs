module Sudoku.Sudoku
( solve
, getSolver
, dispatch
) where

import Data.List
import Data.Maybe

import Sudoku.Data.InnerSudoku
import Sudoku.Data.InputSudoku
import Sudoku.Data.Types
import Sudoku.Solver.Prepare
--import qualified Sudoku.Solver.PenAndPaper.Solver as PAP
import qualified Sudoku.Solver.Auto as A
import qualified Sudoku.Solver.Bruteforce as B

type Solver = InnerSudoku -> Maybe InnerSudoku

dispatch :: [(String, Solver)]
dispatch = [
    ("auto", A.solver),
    ("bruteforce", B.solver)
    ]

-- |The 'solve' function takes a string represantation of a solver and sudoku input and returns either the solution or error string
solve :: Solver -> String -> String
solve solver input = maybe defaultValue show $ solver sudoku
    where
        defaultValue = "No solution"
        sudoku       = prepare . fromInput . readFromString $ input

getSolver :: String -> Maybe Solver
getSolver = flip lookup dispatch

module Sudoku.Solver.Auto
( solver
) where

import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types
import Sudoku.Solver.PenAndPaper.ForcedNumbers
import qualified Sudoku.Solver.Bruteforce as B

-- |The 'solver' function solves sudokus by finding forced numbers and then bruteforcing the solution
solver :: InnerSudoku -> Maybe InnerSudoku
solver = B.solver . findForced

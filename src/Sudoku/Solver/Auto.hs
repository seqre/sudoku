module Sudoku.Solver.Auto
( solver
) where

import Sudoku.Data.InnerSudoku
import Sudoku.Solver.PenAndPaper.ForcedNumbers
import qualified Sudoku.Solver.Bruteforce as B

solver :: InnerSudoku -> Maybe InnerSudoku
solver = B.solver . findForced

module Sudoku.Solver.PenAndPaper.Solver
( solver
) where

import Data.Maybe

import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types
import Sudoku.Solver.Prepare
import Sudoku.Solver.PenAndPaper.ForcedNumbers
--import Sudoku.Solver.PenAndPaper.PreemptiveSets

solver :: InnerSudoku -> Maybe InnerSudoku
solver sudoku = if isCompleted sudoku then Just sudoku
                                      else Nothing
                                      --simplify . findForced

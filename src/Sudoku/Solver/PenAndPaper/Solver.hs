module Sudoku.Solver.PenAndPaper.Solver
( solver
) where

import Sudoku.Data.InnerSudoku
import Sudoku.Solver.Prepare
import Sudoku.Solver.PenAndPaper.ForcedNumbers
import Sudoku.Solver.PenAndPaper.PreemptiveSets
import Utils.Maybe

solver :: InnerSudoku -> Maybe InnerSudoku
solver sudoku = if isCompleted sudoku then Just sudoku
                                      else Nothing
                                      --simplify . findForced
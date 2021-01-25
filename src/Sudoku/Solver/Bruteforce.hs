module Sudoku.Solver.Bruteforce
( solver
) where

import Data.Maybe
import qualified Data.Map as M

import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types
import Sudoku.Solver.Rules

-- |The 'solver' function takes InnerSudoku and returns a Maybe value consisting of solved sudoku or Nothing in the case of error
solver :: InnerSudoku -> Maybe InnerSudoku
solver = flip innerSolver (0,0)

-- |The 'innerSolver' function iterates over cells and appoints cell value finding
innerSolver :: InnerSudoku -> Coord -> Maybe InnerSudoku
innerSolver sudoku@(INS cells) coord | coord == (8,8) = Just sudoku
                                     | isCV cell      = innerSolver sudoku $ advanceCoord coord
                                     | otherwise      = checkList sudoku coord $ getFromCP cell
    where
        cell = cells M.! coord

-- |The 'checkList' function sets cell value to one of the possible ones and checks whether it's a proper solution
checkList  :: InnerSudoku -> Coord -> [Int] -> Maybe InnerSudoku
checkList _      _     []     = Nothing
checkList sudoku coord (l:ls) | not isOk        = checkList sudoku coord ls
                              | isJust nextStep = nextStep
                              | otherwise       = checkList sudoku coord ls
    where
        newSudoku = replaceAt sudoku coord (CV l)
        isOk      = checkIndex newSudoku coord
        nextStep  = innerSolver newSudoku $ advanceCoord coord

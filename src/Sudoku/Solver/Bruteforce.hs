module Sudoku.Solver.Bruteforce
( solver
) where

import Data.Maybe
import qualified Data.Map as M

import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types
import Sudoku.Solver.Rules

solver :: InnerSudoku -> Maybe InnerSudoku
solver = flip innerSolver (0,0)

innerSolver :: InnerSudoku -> Coord -> Maybe InnerSudoku
innerSolver sudoku@(INS cells) coord | coord == (8,8) = Just sudoku
                                     | isCV cell      = innerSolver sudoku $ advanceCoord coord
                                     | otherwise      = checkList sudoku coord $ getFromCP cell
    where
        cell = cells M.! coord

checkList  :: InnerSudoku -> Coord -> [Int] -> Maybe InnerSudoku
checkList _      _     []     = Nothing
checkList sudoku coord (l:ls) | not isOk        = checkList sudoku coord ls
                              | isJust nextStep = nextStep
                              | otherwise       = checkList sudoku coord ls
    where
        newSudoku = replaceAt sudoku coord (CV l)
        isOk      = checkIndex newSudoku coord
        nextStep  = innerSolver newSudoku $ advanceCoord coord

module Sudoku.Solver.Bruteforce
( solver
) where

import Data.Maybe (isNothing, isJust)
import Debug.Trace (trace)

import Sudoku.Data.InnerSudoku
import Sudoku.Solver.Rules

solver :: InnerSudoku -> Maybe InnerSudoku
solver = flip innerSolver 0

innerSolver :: InnerSudoku -> Int -> Maybe InnerSudoku
innerSolver sudoku@(IS cells) n | n == 81   = Just sudoku
                                | isCV cell = innerSolver sudoku (n+1)
                                | otherwise = checkList sudoku n $ getFromCP cell
    where
        cell = cells !! n

checkList  :: InnerSudoku -> Int -> [Int] -> Maybe InnerSudoku
checkList _      _ []     = Nothing
checkList sudoku n (l:ls) | not isOk        = checkList sudoku n ls
                          | isJust nextStep = nextStep
                          | otherwise       = checkList sudoku n ls
    where
        newSudoku = replaceAt sudoku n (CV l)
        isOk      = checkIndex newSudoku n
        nextStep  = innerSolver newSudoku (n+1)
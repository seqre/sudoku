module Sudoku.Solver.Bruteforce
( solve
) where

import Data.Maybe (isNothing, isJust)
import Debug.Trace (trace)

import Sudoku.Data.InnerSudoku
import Sudoku.Solver.Rules

solve :: InnerSudoku -> Maybe InnerSudoku
solve = flip innerSolve 0

innerSolve :: InnerSudoku -> Int -> Maybe InnerSudoku
innerSolve sudoku@(IS cells) n | n == 81   = Just sudoku
                               | isCV cell = innerSolve sudoku (n+1)
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
        nextStep  = innerSolve newSudoku (n+1)
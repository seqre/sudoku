module Main where

import Sudoku.Data.InnerSudoku
import Sudoku.Data.InputSudoku
import Sudoku.Solver.PenAndPaper.Prepare
import Sudoku.Solver.Bruteforce
import Utils.List

test :: String
test = maybe "" (show . getAllVals) $ (solve . prepare) sudoku
    where
        input = "Sudoku:000630010075000000000000000000078400600000030100000000040000708000300500000200000"
        sudoku = fromInput $ readFromString input

main :: IO ()
main = do
    putStrLn "Calculating result..."
    putStrLn $ "Result: " ++ test

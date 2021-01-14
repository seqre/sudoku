module Main where

import Sudoku.Sudoku

main :: IO ()
main = do
    putStrLn "Please provide Sudoku to solve in format `Sudoku:0304234...`:"
    input <- getLine
    putStrLn "Calculating result..."
    putStrLn $ "Result: " ++ solve input

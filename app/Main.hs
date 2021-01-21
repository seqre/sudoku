module Main where

import System.Environment (getArgs)

import Sudoku.Sudoku

main :: IO ()
main = do
    args <- getArgs
    if null args
       then do
           putStrLn "Usage: sudoku-exe SOLVER"
           putStrLn "Available solvers:"
           putStrLn "\t- auto"
           putStrLn "\t- bruteforce"
       else do
           (solver:_) <- getArgs
           putStrLn "Please provide Sudoku to solve in format `Sudoku:0304234...`:"
           input <- getLine
           putStrLn "Calculating result..."
           putStrLn $ "Result: " ++ solve solver input

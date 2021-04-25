module Main where

import System.Environment (getArgs)
import Data.Maybe

import Sudoku.Sudoku (solve, getSolver, dispatch)

-- |The 'printHelp' function prints usage of the program
printHelp :: IO()
printHelp = do
    putStrLn "Usage: sudoku-exe SOLVER"
    putStrLn "Available solvers:"
    putStrLn $ ("\t- " ++) . (++ "\n") . fst =<< dispatch

main :: IO ()
main = do
    args <- getArgs
    if null args
    then do
        printHelp
    else do
        (solverString:_) <- getArgs
        if isJust (getSolver solverString)
            then do
                putStrLn "Please provide Sudoku to solve in format `Sudoku:0304234...`:"
                input <- getLine
                putStrLn "Calculating result..."
                putStrLn "Result:"
                putStrLn $ solve (fromJust $ getSolver solverString) input
            else do
                putStrLn "Such solver does not exist."

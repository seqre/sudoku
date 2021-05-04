module Main where

import System.Environment (getArgs)
import Data.Maybe
import Options.Applicative (execParser)

import Sudoku.Sudoku (solve, getSolver, Solver)
import Sudoku.Parser


-- |The 'readFromFile' function returns list of entries in provided file
readFromFile :: String -> IO [String]
readFromFile = fmap lines . readFile

main :: IO ()
main = entryPoint =<< execParser greeter

-- TODO: Add input validation
entryPoint :: Options -> IO ()
entryPoint (Options algo "")   = processStdIn algo
entryPoint (Options algo file) = processFile algo file

processStdIn :: String -> IO ()
processStdIn = interact . solve . fromJust . getSolver


processFile :: String -> String -> IO ()
processFile algo file = do
    sudokus <- readFromFile file
    solveSudokus (fromJust $ getSolver algo) sudokus

solveSudokus :: Solver -> [String] -> IO ()
solveSudokus solver [] = return ()
solveSudokus solver (s:ss) = do
    putStrLn $ solve solver s
    solveSudokus solver ss

--main = do
--    args <- getArgs
--    if null args
--    then do
--        printHelp
--    else do
--        (solverString:_) <- getArgs
--        if isJust (getSolver solverString)
--            then do
--                putStrLn "Please provide Sudoku to solve in format `Sudoku:0304234...`:"
--                input <- getLine
--                putStrLn "Calculating result..."
--                putStrLn "Result:"
--                putStrLn $ solve (fromJust $ getSolver solverString) input
--            else do
--                putStrLn "Such solver does not exist."


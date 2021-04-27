module Sudoku.Parser
( greeter
) where

import Options.Applicative
import Data.Semigroup ((<>))

import Sudoku.Sudoku (dispatch)

data Options = Options {
    algorithm   :: String,
    file        :: String
} deriving (Show)


options :: Parser Options
options = Options
        <$> strOption
            (  long         "algorithm"
            <> short        'a'
            <> metavar      "ALGO"
            <> value        "auto"
            <> showDefault
            <> completer    (listCompleter solvers)
            <> help         "Algorithm to be used" )
        <*> strOption
            (  long     "file"
            <> short    'f'
            <> metavar  "FILE"
            <> value    ""
            <> help     "File path with     sudokus to solve" )


greeter :: ParserInfo Options
greeter = info (options <**> helper)
        (  fullDesc
        <> footer   solversDoc
        <> header   "sudoku-solver - solver for sudoku with different algorithms" )

-- TODO: Change to DOC
solversDoc :: String
solversDoc = "Available solvers:" ++ (("\t" ++) =<< solvers)

solvers :: [String]
solvers = map fst dispatch

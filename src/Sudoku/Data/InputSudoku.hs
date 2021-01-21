module Sudoku.Data.InputSudoku
( InputSudoku (..)
, readFromString
) where

import Data.Maybe (maybe)
import Utils.List (intersperse)

newtype InputSudoku = Input [Int] deriving (Eq)

instance Show InputSudoku where
    show (Input nums) = showSudoku $ concatMap show nums
        where
            showSudoku []       = ""
            showSudoku numbers  = let (prev, next) = splitAt 9 numbers
                                  in  intersperse ' ' prev ++ "\n" ++ showSudoku next

readFromString :: String -> InputSudoku
readFromString input@('S':'u':'d':'o':'k':'u':':':nums) = maybe (Input $ getNumbers nums) error errorString
    where
        errorString = checkInput input
        getNumbers = map (\x -> read x :: Int) . words . intersperse ' '

checkInput :: String -> Maybe String
checkInput ('S':'u':'d':'o':'k':'u':':':nums)   | length nums /= 81 = Just "Sudoku must have 81 numbers"
                                                | not $ all (`elem` ['0'..'9']) nums = Just "Accepted characters are numbers from 0 to 9"
                                                | otherwise = Nothing
checkInput _ = Just "Missing or incorrect preamble"
-- TODO: Fix this ^
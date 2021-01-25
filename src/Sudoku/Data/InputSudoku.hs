module Sudoku.Data.InputSudoku
( InputSudoku (..)
, readFromString
) where

import Data.List
import qualified Data.Map as M
import Data.Maybe

import Sudoku.Data.Types


-- |The 'readFromString' function constructs InputSudoku from provided string
readFromString :: String -> InputSudoku
readFromString input@('S':'u':'d':'o':'k':'u':':':nums) = maybe (IPS sudokuVals) error errorString
    where
        errorString = checkInput input
        sudokuVals  = createMap $ getNumbers nums
readFromString _ = error "Missing or incorrect preamble"

-- |The 'checkInput' function check numerical part of input
checkInput :: String -> Maybe String
checkInput ('S':'u':'d':'o':'k':'u':':':nums) | length nums /= 81 = Just "Sudoku must have 81 numbers"
                                              | not $ all (`elem` ['0'..'9']) nums = Just "Accepted characters are numbers from 0 to 9"
                                              | otherwise = Nothing
getNumbers :: String -> [Int]
getNumbers  = map read . words . intersperse ' '

createMap :: [Int] -> M.Map Coord Int
createMap = M.fromList . zip coords
    where
        coords = [(x,y) | x <- [0..8], y <- [0..8]]

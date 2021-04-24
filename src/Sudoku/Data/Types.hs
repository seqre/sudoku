module Sudoku.Data.Types 
where

import qualified Data.Map as M

--
-- TYPES DECLARATION 
--

type Coord = (Int, Int)

data Cell = CV Int | CP [Int] deriving (Eq)

type InnerVals = M.Map Coord Cell

newtype InputSudoku = IPS (M.Map Coord Int) deriving (Eq)

newtype InnerSudoku = INS InnerVals deriving (Eq)

--
-- TYPES INSTANCES
--

instance Show Cell where
    show (CV val)  = show val
    show (CP vals) = "-"

instance Show InputSudoku where
    show (IPS vals) = showSudoku . concatMap show . M.elems $ vals 

instance Show InnerSudoku where
    show (INS vals) = showSudoku $ M.elems vals 


--
-- ADDITIONAL FUNCS
--

showSudoku :: (Show a) => [a] -> String
showSudoku []       = ""
showSudoku numbers  = let (prev, next) = splitAt 9 numbers
                      in  (unwords . map show) prev ++ "\n" ++ showSudoku next

advanceCoord :: Coord -> Coord
advanceCoord (x,y) = if x /= 8 then (x + 1, y) else (0, y + 1)

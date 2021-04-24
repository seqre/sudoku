module Sudoku.Data.InnerSudoku
where

import Data.List
import qualified Data.Map as M

import Sudoku.Data.Indices
import Sudoku.Data.InputSudoku
import Sudoku.Data.Types

import Utils.List (splitEvery)

fromInput :: InputSudoku -> InnerSudoku
fromInput (IPS cells) = INS $ M.map assignCell cells
    where
        assignCell num = if num /= 0 then CV num else CP [1..9]

replaceAt :: InnerSudoku -> Coord -> Cell -> InnerSudoku
replaceAt (INS cells) coord newCell = if isCV newCell then INS cleanedCells
                                                      else INS newCells
    where
        newCells         = M.adjust (const newCell) coord cells
        val              = getFromCV newCell
        cleanedCells     = removeValFromDependentCP newCells val $ getDependentIndices coord

removeValFromDependentCP :: InnerVals -> Int -> [Coord] -> InnerVals
removeValFromDependentCP cells _   []     = cells
removeValFromDependentCP cells val (c:cs) = if isCP $ cells M.! c
                                            then removeValFromDependentCP newCells val cs
                                            else removeValFromDependentCP cells val cs
    where
        newCells = M.adjust (flip removeFromCP val) c cells


removeFromCP :: Cell -> Int -> Cell
removeFromCP (CP vals) val = CP $ delete val vals

getAllVals :: InnerSudoku -> [Int]
getAllVals (INS cells) = M.elems $ M.map func cells
    where
        func (CV val) = val
        func (CP _)   = 0

getVals :: InnerSudoku -> [Coord] -> [Int]
getVals (INS cells) = map getFromCV . filter isCV . map (cells M.!)

getPoss :: InnerSudoku -> [Coord] -> [[Int]]
getPoss (INS cells) = map getFromCP . filter isCP . map (cells M.!)

getFromCV :: Cell -> Int
getFromCV (CV val) = val

getFromCP :: Cell -> [Int]
getFromCP (CP val) = val

isCV :: Cell -> Bool
isCV (CV _) = True
isCV _      = False

isCP :: Cell -> Bool
isCP (CP _) = True
isCP _      = False

isCompleted :: InnerSudoku -> Bool
isCompleted (INS cells) = (not . any isCP) cells

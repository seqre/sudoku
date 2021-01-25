module Sudoku.Data.InnerSudoku
where

import Data.List
import qualified Data.Map as M

import Sudoku.Data.Indices
import Sudoku.Data.InputSudoku
import Sudoku.Data.Types

import Utils.List (splitEvery)

-- |The 'fromInput' function transfrom InputSudoku to InnerSudoku
fromInput :: InputSudoku -> InnerSudoku
fromInput (IPS cells) = INS $ M.map assignCell cells
    where
        assignCell num = if num /= 0 then CV num else CP [1..9]

-- |The 'replaceAt' function replaces the call at specified index with cell and if is CV then updates all dependent CP cells
replaceAt :: InnerSudoku -> Coord -> Cell -> InnerSudoku
replaceAt (INS cells) coord newCell = if isCV newCell then INS cleanedCells
                                                      else INS newCells
    where
        newCells         = M.adjust (const newCell) coord cells
        val              = getFromCV newCell
        cleanedCells     = removeValFromDependentCP newCells val $ getDependentIndices coord

-- |The 'removeValFromDependentCP' function removes val of new cell from dependent CP cells
removeValFromDependentCP :: InnerVals -> Int -> [Coord] -> InnerVals
removeValFromDependentCP cells _   []     = cells
removeValFromDependentCP cells val (c:cs) = if isCP $ cells M.! c
                                            then removeValFromDependentCP newCells val cs
                                            else removeValFromDependentCP cells val cs
    where
        newCells = M.adjust (flip removeFromCP val) c cells


removeFromCP :: Cell -> Int -> Cell
removeFromCP (CP vals) val = CP $ delete val vals

-- |The 'getAllVals' function returns all vals from sudoku with 0 for CP
getAllVals :: InnerSudoku -> [Int]
getAllVals (INS cells) = M.elems $ M.map func cells
    where
        func (CV val) = val
        func (CP _)   = 0

-- |The 'getVals' function returns vals of specified indices
getVals :: InnerSudoku -> [Coord] -> [Int]
getVals (INS cells) = map getFromCV . filter isCV . map (cells M.!)

-- |The 'getPoss' function returns CP vals of specified indices
getPoss :: InnerSudoku -> [Coord] -> [[Int]]
getPoss (INS cells) = map getFromCP . filter isCP . map (cells M.!)

-- |The 'getFromCV' function extracts value from CV cell
getFromCV :: Cell -> Int
getFromCV (CV val) = val

-- |The 'getFromCP' function extracts values from CP cell
getFromCP :: Cell -> [Int]
getFromCP (CP val) = val

-- |The 'isCV' function checks whether cell is CV
isCV :: Cell -> Bool
isCV (CV _) = True
isCV _      = False

-- |The 'isCP' function checks whether cell is CP
isCP :: Cell -> Bool
isCP (CP _) = True
isCP _      = False

-- |The 'isCompleted' function checks whether sudoku is completed
isCompleted :: InnerSudoku -> Bool
isCompleted (INS cells) = (not . any isCP) cells

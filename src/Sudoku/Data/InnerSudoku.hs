module Sudoku.Data.InnerSudoku
where

import Utils.List
import Sudoku.Data.Indices
import Sudoku.Data.InputSudoku

data Cell = CV Int | CP [Int] deriving (Eq)

newtype InnerSudoku = IS [Cell] deriving (Eq)

instance Show Cell where
    show (CV val)  = show val
    show (CP vals) = "-"

instance Show InnerSudoku where
    show (IS cells) = showSudoku cells
        where
            showSudoku []    = ""
            showSudoku vals  = let (prev, next) = splitAt 9 vals
                               in  (unwords . map show) prev ++ "\n" ++ showSudoku next
                                
hash :: InnerSudoku -> String
hash (IS cells) = show $ fold summed
    where
        allVals           = splitEvery 9 $ map mapFunc cells
        mapFunc (CV val)  = val
        mapFunc (CP vals) = - (sum vals)
        summed            = map fold allVals
        fold              = foldl (\acc el -> acc * 9 + el) 0

fromInput :: InputSudoku -> InnerSudoku
fromInput (Input cells) = IS mapped
    where
        mapped         = map assignCell cells
        assignCell num = if num /= 0 then CV num else CP [1..9]

replaceAt :: InnerSudoku -> Int -> Cell -> InnerSudoku
replaceAt (IS cells) n newCell = IS cleanedCells
    where
        (prev, _ : next) = splitAt n cells
        newCells         = prev ++ [newCell] ++ next
        val              = getFromCV newCell
        cleanedCells     = removeValFromDependentCP newCells val $ getDependentIndices n

removeValFromDependentCP :: [Cell] -> Int -> [Int] -> [Cell]
removeValFromDependentCP cells _   []     = cells
removeValFromDependentCP cells val (i:is) = if isCP cell
                                            then prev ++ [newCell] ++ nextStep
                                            else prev ++ [cell] ++ nextStep
    where
        (prev, cell : next) = splitAt i cells
        newInd              = map (flip (-) (i + 1)) is
        newCell             = CP (delete val $ getFromCP cell)
        nextStep            = removeValFromDependentCP next val newInd

getAllVals :: InnerSudoku -> [Int]
getAllVals (IS cells) = map func cells
    where
        func (CV val) = val
        func (CP _)   = 0

getVals :: InnerSudoku -> [Int] -> [Int]
getVals (IS cells) = map getFromCV . filter isCV . map (cells !!)

getPoss :: InnerSudoku -> [Int] -> [[Int]]
getPoss (IS cells) = map getFromCP . filter isCP . map (cells !!)

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
isCompleted (IS cells) = (not . any isCP) cells
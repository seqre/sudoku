module Sudoku.Data.InnerSudoku
where


import Utils.List
import Sudoku.Data.InputSudoku

data Cell = CV Int | CP [Int] deriving (Show, Eq)

newtype InnerSudoku = IS [Cell] deriving (Show, Eq)

fromInput :: InputSudoku -> InnerSudoku
fromInput (Input nums) = IS mapped
    where
        mapped = map assignCell nums
        assignCell num = if num /= 0 then CV num else CP [1..9]

replaceAt :: InnerSudoku -> Int -> Cell -> InnerSudoku
replaceAt (IS cells) n newCell = IS newCells
    where
        (prev, _ : next) = splitAt n cells
        newCells = prev ++ [newCell] ++ next

getAllVals :: InnerSudoku -> [Int]
getAllVals (IS cells) = map func cells
    where
        func (CV val) = val
        func (CP _)   = 0

getVals :: InnerSudoku -> [Int] -> [Int]
getVals (IS cells) = map getFromCV . filter isCV . map (cells !!)

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
module Sudoku.Solver.PenAndPaper.ForcedNumbers
( findForced
) where

import Data.List (sort, nub, group)

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku

findForced :: InnerSudoku -> InnerSudoku
findForced sudoku = if sudoku == newSudoku then sudoku
                                           else findForced newSudoku
    where
        newSudoku = innerFindForced sudoku allFormIndices

innerFindForced :: InnerSudoku -> [[Int]] -> InnerSudoku
innerFindForced sudoku            []     = sudoku
innerFindForced sudoku@(IS cells) (b:bs) = if null singles then innerFindForced sudoku bs
                                                           else innerFindForced newSudoku bs
    where
        singles = getSingles $ getFrequencyAssocs sudoku b
        newSudoku = changeSingles sudoku b singles

getFrequencyAssocs :: InnerSudoku -> [Int] -> [(Int, Int)]
getFrequencyAssocs (IS cells) = assocs . vals
    where
        vals = concatMap getFromCP . filter isCP . map (cells !!)
        assocs = map (\l -> (head l, length l)) . group . sort

getSingles :: [(Int, Int)] -> [Int]
getSingles = map fst . filter ((== 1) . snd)

changeSingles :: InnerSudoku -> [Int] -> [Int] -> InnerSudoku
changeSingles sudoku            _       []     = sudoku
changeSingles sudoku@(IS cells) indices (s:ss) = changeSingles newSudoku indices ss
    where
        index = fst . head . filter (elem s . snd) . map helper . filter filterCheck $ indices
        helper i = (i, getFromCP $ cells !! i)
        filterCheck = isCP . (cells !!)
        newSudoku = replaceAt sudoku index (CV s)
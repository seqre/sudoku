module Sudoku.Solver.PenAndPaper.ForcedNumbers
( findForced
) where

import Data.List
import Data.Tuple
import Data.Tuple.Extra
import qualified Data.Map as M

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types

-- |The 'findForced' function finds and sets forced numbers as long as can find them
findForced :: InnerSudoku -> InnerSudoku
findForced sudoku = if sudoku == newSudoku then sudoku
                                           else findForced newSudoku
    where
        newSudoku = innerFindForced sudoku allFormIndices

-- |The 'innerFindForced' function iterates over groups of indices and finds forced numbers
innerFindForced :: InnerSudoku -> [[Coord]] -> InnerSudoku
innerFindForced sudoku []     = sudoku
innerFindForced sudoku (b:bs) = if null singles then innerFindForced sudoku bs
                                                else innerFindForced newSudoku bs
    where
        singles   = getSingles $ getFrequencyAssocs sudoku b
        newSudoku = changeSingles sudoku b singles

-- |The 'getFrequencyAssocs' function calculates frequency of each number in set of indices
getFrequencyAssocs :: InnerSudoku -> [Coord] -> [(Int, Int)]
getFrequencyAssocs (INS cells) = assocs . vals
    where
        vals   = concatMap getFromCP . filter isCP . map (cells M.!)
        assocs = map (head &&& length) . group . sort

-- |The 'getSingles' function returns numbers appearing once in a set
getSingles :: [(Int, Int)] -> [Int]
getSingles = map fst . filter ((== 1) . snd)

-- |The 'changeSingles' function set cells to single values and removes them from CP cells
changeSingles :: InnerSudoku -> [Coord] -> [Int] -> InnerSudoku
changeSingles sudoku             _       []     = sudoku
changeSingles sudoku@(INS cells) indices (s:ss) = changeSingles newSudoku indices ss
    where
        index       = fst . head . filter (elem s . snd) . map helper . filter filterCheck $ indices
        helper i    = (i, getFromCP $ cells M.! i)
        filterCheck = isCP . (cells M.!)
        newSudoku   = replaceAt sudoku index (CV s)

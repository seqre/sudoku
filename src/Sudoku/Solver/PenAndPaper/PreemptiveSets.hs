module Sudoku.Solver.PenAndPaper.PreemptiveSets
(
) where

import Data.List
import Data.Maybe
import Data.Tuple

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku

--data Set = S {values :: [Int], indices :: [Int], dependent :: [Int]}
--
--simplify :: InnerSudoku -> InnerSudoku
--simplify sudoku | isCompleted sudoku  = sudoku
--                | sudoku == newSudoku = randomChoice newSudoku
--                | otherwise           = simplify newSudoku
--    where
--        newSudoku = innerSimplify sudoku allFormIndices
--
--innerSimplify :: InnerSudoku -> [[Int]] -> InnerSudoku
--innerSimplify sudoku            []     = sudoku
--innerSimplify sudoku@(IS cells) (l:ls) = if isJust set then innerSimplify newSudoku ls
--                                                       else innerSimplify sudoku ls
--    where
--        set = findSet sudoku $ filter (isCP . (cells !!)) l
--        newSudoku = changeWithSet sudoku $ fromJust set
--
--randomChoice :: InnerSudoku -> InnerSudoku
--randomChoice sudoku@(IS cells) = innerRandomChoice sudoku ind $ getFromCP cp
--    where
--        (ind, cp) = head . filter (isCP . snd) $ zip [0..] cells
--
--innerRandomChoice :: InnerSudoku -> Int -> [Int] -> InnerSudoku
--innerRandomChoice sudoku            _   []     = sudoku
--innerRandomChoice sudoku@(IS cells) ind (o:op) = if isCompleted newSudoku 
--                                                 then newSudoku
--                                                 else innerRandomChoice sudoku ind op
--    where
--        newSudoku = replaceAt sudoku ind (CV o)
--        next = simplify newSudoku
--
--findSet :: InnerSudoku -> [Int] -> Maybe Set
--findSet sudoku@(IS cells) indices = maybe Nothing createSet candidate
--    where
--        posses = getPoss sudoku indices
--        candidate = findSetHelper posses 1
--        indexedPoss = filter (isCP . snd) . map (\i -> (i, cells !! i)) $ indices
--        getIndFromVals vals = map fst . filter ((== vals) . getFromCP . snd) $ indexedPoss
--        createSet vals = let valsIndices = getIndFromVals vals
--                         in  Just (S vals valsIndices (indices \\ valsIndices))
--
--findSetHelper :: [[Int]] -> Int -> Maybe [Int]
--findSetHelper _      10 = Nothing
--findSetHelper posses n  = if isJust samePoss then samePoss
--                                             else findSetHelper posses (n + 1)
--    where
--        sameLength = sort . filter ((== n) . length) $ posses
--        samePoss = findSamePoss sameLength n
--
--findSamePoss :: [[Int]] -> Int -> Maybe [Int]
--findSamePoss []     n = Nothing
--findSamePoss posses n = if length same == n then Just $ head posses
--                                            else findSamePoss rest n
--    where
--        (same, rest) = span (== head posses) posses
--
--changeWithSet :: InnerSudoku -> Set -> InnerSudoku
--changeWithSet sudoku@(IS cells) set = IS newCells
--    where
--        newCells = zipWith func [0..] cells
--        func ind cp = if elem ind (dependent set) then CP (getFromCP cp \\ values set)
--                                                  else cp

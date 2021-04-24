module Sudoku.Solver.Prepare
( prepare
) where

import Data.List
import qualified Data.Map as M

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types

prepare :: InnerSudoku -> InnerSudoku
prepare = flip innerPrepare (0,0)

innerPrepare :: InnerSudoku -> Coord -> InnerSudoku
innerPrepare sudoku@(INS cells) coord | coord == (8,8) = sudoku
                                      | isCV cell = innerPrepare sudoku $ advanceCoord coord
                                      | otherwise = innerPrepare processed $ advanceCoord coord
    where
        cell      = cells M.! coord
        processed = processCell sudoku coord

processCell :: InnerSudoku -> Coord -> InnerSudoku
processCell sudoku@(INS cells) coord = replaceAt sudoku coord $ CP newVals
    where
        indices          = getDependentIndices coord
        vals             = getVals sudoku indices
        newVals          = [1..9] \\ vals

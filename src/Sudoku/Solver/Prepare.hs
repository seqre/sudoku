module Sudoku.Solver.Prepare
( prepare
) where

import Data.List
import qualified Data.Map as M

import Sudoku.Data.Indices
import Sudoku.Data.InnerSudoku
import Sudoku.Data.Types

-- |The 'prepare' function returns sudoku with only possible values in CP cells
prepare :: InnerSudoku -> InnerSudoku
prepare = flip innerPrepare (0,0)

-- |The 'innerPrepare' function iterates over cells and appoints removal of impossible values
innerPrepare :: InnerSudoku -> Coord -> InnerSudoku
innerPrepare sudoku@(INS cells) coord | coord == (8,8) = sudoku
                                      | isCV cell = innerPrepare sudoku $ advanceCoord coord
                                      | otherwise = innerPrepare processed $ advanceCoord coord
    where
        cell      = cells M.! coord
        processed = processCell sudoku coord

-- |The 'processCell' function removes impossible values from specified CP cell
processCell :: InnerSudoku -> Coord -> InnerSudoku
processCell sudoku@(INS cells) coord = replaceAt sudoku coord $ CP newVals
    where
        indices          = getDependentIndices coord
        vals             = getVals sudoku indices
        newVals          = [1..9] \\ vals

module Utils.List
where

-- |The 'splitEvery' function splits list into sublists of fixed length
splitEvery :: Int -> [a] -> [[a]]
splitEvery _ []   = []
splitEvery n list = let (prev, next) = splitAt n list
                    in  prev : splitEvery n next
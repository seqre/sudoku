module Utils.List
where

splitEvery :: Int -> [a] -> [[a]]
splitEvery _ []   = []
splitEvery n list = let (prev, next) = splitAt n list
                    in  prev : splitEvery n next

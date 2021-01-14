module Utils.List
( splitEvery
, intersperse
) where

splitEvery :: Int -> [a] -> [[a]]
splitEvery _ []   = []
splitEvery n list = let (prev, next) = splitAt n list
                    in  prev : splitEvery n next

intersperse :: a -> [a] -> [a]
intersperse _    [x]    = [x]
intersperse char (l:ls) = l : char : intersperse char ls
module Utils.List
where

splitEvery :: Int -> [a] -> [[a]]
splitEvery _ []   = []
splitEvery n list = let (prev, next) = splitAt n list
                    in  prev : splitEvery n next

intersperse :: a -> [a] -> [a]
intersperse _    []     = []
intersperse _    [x]    = [x]
intersperse char (l:ls) = l : char : intersperse char ls

intercalate :: [a] -> [[a]] -> [a]
intercalate xs xss = concat (intersperse xs xss)

nub :: (Eq a) => [a] -> [a]
nub []     = []
nub (x:xs) = x : nub (filter (/= x) xs)

sort :: (Ord a) => [a] -> [a]
sort []     = []
sort (l:ls) = sort smaller ++ [l] ++ sort bigger
    where
        (smaller, bigger) = partition (<= l) ls

partition :: (a -> Bool) -> [a] -> ([a], [a])
partition p xs = (filter p xs, filter (not . p) xs)

delete :: (Eq a) => a -> [a] -> [a]
delete _   []     = []
delete val (l:ls) = if val == l then ls else l : delete val ls

group :: (Eq a) => [a] -> [[a]]
group []     = []
group (l:ls) = (l:same) : group rest
    where
        (same, rest) = span (== l) ls

(\\) :: (Eq a) => [a] -> [a] -> [a]
(\\) = foldl (flip delete)
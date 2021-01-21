module Utils.Tuple
where

second :: (b -> b') -> (a, b) -> (a, b')
second func (a, b) = (a, func b)

(&&&) :: (a -> b) -> (a -> c) -> a -> (b, c) 
f &&& g = \x -> (f x, g x)
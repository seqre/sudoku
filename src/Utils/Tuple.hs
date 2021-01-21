module Utils.Tuple
( second
) where

second :: (b -> b') -> (a, b) -> (a, b')
second func (a, b) = (a, func b)
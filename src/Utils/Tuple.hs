module Utils.Tuple
where

second :: (b -> b') -> (a, b) -> (a, b')
second func (a, b) = (a, func b)
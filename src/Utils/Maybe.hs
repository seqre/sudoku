module Utils.Maybe
where

maybe :: b -> (a -> b) -> Maybe a -> b
maybe def _    Nothing = def
maybe _   func (Just x) = func x

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust _        = False

isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing _       = False

fromJust :: Maybe a -> a
fromJust (Just x) = x
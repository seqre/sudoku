module Utils.Maybe
where

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust _        = False

isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing _       = False

fromJust :: Maybe a -> a
fromJust (Just x) = x
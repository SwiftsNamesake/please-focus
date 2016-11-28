
--------------------------------------------------------------------------------------------------------------------------------------------

module Focus exposing (..)

--------------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------------

type alias Setter s t a b = (a -> b) -> s -> t

type alias HasSize v n = {v|size : n}
type alias HasX v n    = {v|x : n}

--------------------------------------------------------------------------------------------------------------------------------------------

{-| Sets 'size' -}
setSize : Setter {v| size : n } {v| size : m } n m -- (n -> m) -> {v| size : n } -> {v| size : m }
setSize f v = {v|size = f v.size}


{-| Sets 'x' -}
setX : Setter {v| x : n } {v| x : m } n m
setX f v = {v|x = f v.x}


{-| Compose two setters -}
compose : Setter s t a b -> Setter a b c d -> Setter s t c d
compose f g = \ap s -> f (g ap) s


{-| Synonym for compose (TODO: Rename?) -}
(=>) : Setter s t a b -> Setter a b c d -> Setter s t c d
(=>) f g = compose f g


{-| Apply setter to constant value (TODO: Rename?) -}
(.=) : Setter s t a b -> b -> s -> t
(.=) f a s = f (always a) s


{-| Apply setter to constant value (TODO: Rename?) -}
($=) : Setter s t a b -> (a -> b) -> s -> t
($=) f g s = f g s


--------------------------------------------------------------------------------------------------------------------------------------------

module Focus exposing (..)
{-| Sort-of lenses

# Types
@docs Setter

# Operators
@docs compose, (=>), (.=), ($=), (&)

-}

--------------------------------------------------------------------------------------------------------------------------------------------

{-| 'Setter's work by applying a function to a given field -}
type alias Setter s t a b = (a -> b) -> s -> t

--------------------------------------------------------------------------------------------------------------------------------------------

{-| Compose two setters -}
compose : Setter s t a b -> Setter a b c d -> Setter s t c d
compose f g = \ap s -> f (g ap) s


{-| Synonym for compose (TODO: Rename?) -}
(=>) : Setter s t a b -> Setter a b c d -> Setter s t c d
(=>) f g = compose f g


{-| Apply setter to constant value (TODO: Rename?) -}
(.=) : Setter s t a b -> b -> s -> t
(.=) f a = \ s -> f (always a) s


{-| Apply setter to constant value (TODO: Rename?) -}
($=) : Setter s t a b -> (a -> b) -> s -> t
($=) f g = \s -> f g s


{-| Reverse type application -}
(&) : a -> (a -> b) -> b
(&) x f = f x

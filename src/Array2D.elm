module Array2D exposing (..)

import Array exposing (..)
import Maybe exposing (..)


type alias Array2D a =
    Array (Array a)


fill : Int -> Int -> a -> Array2D a
fill rowLength colLength data =
    Array.repeat rowLength (Array.repeat colLength data)


get : Int -> Int -> Array2D a -> Maybe a
get rowIndex colIndex rows =
    Array.get rowIndex rows
        |> andThen
            (\row ->
                Array.get colIndex row
            )


set : Int -> Int -> a -> Array2D a -> Array2D a
set rowIndex colIndex data rows =
    case Array.get rowIndex rows of
        Just row ->
            Array.set rowIndex (Array.set colIndex data row) rows

        Nothing ->
            rows


map : (a -> b) -> Array2D a -> Array2D b
map f rows =
    Array.map (Array.map f) rows


indexedMap : (Int -> Int -> a -> b) -> Array2D a -> Array2D b
indexedMap f rows =
    Array.indexedMap (Array.indexedMap << f) rows


foldl : (a -> b -> b) -> b -> Array2D a -> b
foldl f init rows =
    Array.foldl (\row memo -> Array.foldl f memo row) init rows


toList : Array2D a -> List (List a)
toList rows =
    Array.toList (Array.map Array.toList rows)

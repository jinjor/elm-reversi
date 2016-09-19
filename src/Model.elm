module Model exposing (..)


import Array2D exposing (..)


type alias Cell = Maybe Bool
type alias RowIndex = Int
type alias ColIndex = Int


type alias Model =
  { host : String
  , cells : Array2D Cell
  , selected : Maybe (RowIndex, ColIndex)
  , turn : Bool -- 1P: True, 2P: False
  }


model : String -> Model
model host =
  { host = host
  , cells = initialCells
  , selected = Nothing
  , turn = True -- 1P: True, 2P: False
  }


initialKomas : List (Int, Int, Bool)
initialKomas =
  [ (3, 3, True)
  , (3, 4, False)
  , (4, 3, False)
  , (4, 4, True)
  ]


initialCells : Array2D Cell
initialCells =
  let
    empty =
      Array2D.fill 8 8 Nothing
  in
    List.foldl (\(rowIndex, colIndex, player) rows ->
      set rowIndex colIndex (Just player) rows
    ) empty initialKomas


count : Array2D Cell -> (Int, Int, Int)
count cells =
  Array2D.foldl (\data (p1, p2, em) ->
    case data of
      Just True -> (p1 + 1, p2, em)
      Just False -> (p1, p2 + 1, em)
      Nothing -> (p1, p2, em + 1)
  ) (0, 0, 0) cells


directions : List (Int, Int)
directions =
  [ (-1, 0)
  , (-1, 1)
  , (0, 1)
  , (1, 1)
  , (1, 0)
  , (1, -1)
  , (0, -1)
  , (-1, -1)
  ]


putKoma : RowIndex -> ColIndex -> Bool -> Array2D Cell -> Maybe (Array2D Cell)
putKoma rowIndex colIndex player rows =
  let
    komasToBeGot =
      List.foldl (\(incrRow, incrCol) memo ->
        memo ++ putKomaHelp rows incrRow incrCol player (rowIndex + incrRow) (colIndex + incrCol) []
      ) [] directions
  in
    case get rowIndex colIndex rows of
      Just Nothing ->
        if komasToBeGot == [] then
          Nothing
        else
          Just <|
            List.foldl (\(rowIndex, colIndex) rows ->
              set rowIndex colIndex (Just player) rows
            ) rows ((rowIndex, colIndex) :: komasToBeGot)

      Just _ ->
        Nothing

      Nothing ->
        Nothing


putKomaHelp : Array2D Cell -> Int -> Int -> Bool -> RowIndex -> ColIndex -> List (RowIndex, ColIndex) -> List (RowIndex, ColIndex)
putKomaHelp rows incrRow incrCol player rowIndex colIndex prev =
  case Array2D.get rowIndex colIndex rows of
    Nothing ->
      []

    Just Nothing ->
      []

    Just (Just color) ->
      if color == player then
        prev

      else
        putKomaHelp
          rows
          incrRow
          incrCol
          player
          (rowIndex + incrRow)
          (colIndex + incrCol)
          ((rowIndex, colIndex) :: prev)

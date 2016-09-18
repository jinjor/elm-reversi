module Update exposing (..)


import Array2D exposing (..)
import Model exposing (..)


type Msg =
  Click RowIndex ColIndex


update : Msg -> Model -> Model
update msg model =
  case msg of
    Click rowIndex colIndex ->
      case putKoma rowIndex colIndex (model.turn) model.cells of
        Just cells ->
          { model |
            cells = cells
          , turn = not model.turn
          }
        Nothing ->
          model

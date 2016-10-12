module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Array2D exposing (..)
import Model exposing (..)
import Update exposing (..)
import Styles as S


view : Model -> Html Msg
view model =
  div
    [ style S.all ]
    [ header
    , boardView model
    , statusView model
    ]


header : Html Msg
header =
  h1 [ style S.title ] [ text "Reversi" ]


statusView : Model -> Html Msg
statusView model =
  let
    (p1, p2, _) =
      count model.cells

    points =
      toString p1 ++ " - " ++ toString p2
  in
    div
      [ style S.status ]
      [ div [ style S.statusSpacer ] []
      , komaForStatus True
      , div [ style S.points ] [ text points ]
      , komaForStatus False
      , div [ style S.statusSpacer ] []
      , div [ style (S.statusPlayerBar model.turn) ] []
      ]


komaForStatus : Bool -> Html Msg
komaForStatus player =
  div [ style (S.komaForStatus player) ] []


boardView : Model -> Html Msg
boardView model =
  let
    cellsList =
      Array2D.toList model.cells
  in
    div [ style S.board ]
      (List.indexedMap
        (\rowIndex row ->
          rowView rowIndex row
        )
        cellsList
      )


rowView : Int -> List Cell -> Html Msg
rowView rowIndex row =
  div [ style S.row ]
    (List.indexedMap (cellView rowIndex) row)


cellView : Int -> Int -> Cell -> Html Msg
cellView rowIndex colIndex cell =
  div
    [ style S.cell
    , onClick (Click rowIndex colIndex)
    ]
    [ komaView cell ]


komaView : Cell -> Html Msg
komaView cell =
  case cell of
    Just player ->
      div [ style (S.koma player) ] []

    Nothing ->
      text ""

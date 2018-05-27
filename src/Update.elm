module Update exposing (..)

import Array2D exposing (..)
import Model exposing (..)
import WS exposing (..)


type Msg
    = NoOp
    | Click RowIndex ColIndex
    | Receive WS.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )

        Click rowIndex colIndex ->
            case putKoma rowIndex colIndex model.turn model.cells of
                Just cells ->
                    ( { model
                        | cells = cells
                        , turn = not model.turn
                      }
                    , sendPutKoma model.host model.turn rowIndex colIndex
                    )

                Nothing ->
                    ( model
                    , Cmd.none
                    )

        Receive (PutKoma player rowIndex colIndex) ->
            case putKoma rowIndex colIndex player model.cells of
                Just cells ->
                    ( { model
                        | cells = cells
                        , turn = not player
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( model
                    , Cmd.none
                    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map Receive (listen model.host)

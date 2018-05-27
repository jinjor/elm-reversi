module Main exposing (..)

import Model exposing (..)
import Navigation exposing (..)
import Update exposing (..)
import View exposing (..)
import WS exposing (..)


main : Program Never Model Update.Msg
main =
    program
        (always NoOp)
        { init =
            \location ->
                ( model location.hostname
                , Cmd.none
                )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

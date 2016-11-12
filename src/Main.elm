import Navigation exposing (..)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import WS exposing (..)


main : Program Never Model Update.Msg
main =
  program
    (always NoOp)
    { init = \location -> model location.hostname ! []
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

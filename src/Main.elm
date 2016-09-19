import Navigation exposing (..)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import WS exposing (..)


main : Program Never
main =
  program
    parser
    { init = \host -> model host ! []
    , view = view
    , update = update
    , urlUpdate = \_ model -> model ! []
    , subscriptions = subscriptions
    }


parser : Parser String
parser =
  makeParser .hostname

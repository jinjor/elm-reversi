import Html.App exposing (..)

import Model exposing (..)
import Update exposing (..)
import View exposing (..)


main : Program Never
main =
  beginnerProgram
    { model = model, view = view, update = update }

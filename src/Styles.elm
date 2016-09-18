module Styles exposing (..)

type alias Style = List (String, String)


all : Style
all =
  [ ("text-align", "center")
  ]


title : Style
title =
  [ ("color", "#496") ]


board : Style
board =
  [ ("background-color", "#222")
  , ("margin-right", "auto")
  , ("margin-left", "auto")
  , ("width", "320px")
  ]


status : Style
status =
  [ ("background-color", "#aaa")
  , ("margin-right", "auto")
  , ("margin-left", "auto")
  , ("width", "320px")
  , ("font-size", "20px")
  , ("padding", "10px")
  , ("padding-bottom", "14px")
  , ("margin-top", "10px")
  , ("border-radius", "3px")
  , ("box-sizing", "border-box")
  , ("display", "flex")
  , ("position", "relative")
  ]


statusSpacer : Style
statusSpacer =
  [ ("flex-grow", "1")
  ]


statusPlayerBar : Bool -> Style
statusPlayerBar player =
  let
    center = 160
    barWidth = 20
    left = center + (if player then (-1) else 1) * 50 - barWidth / 2
  in
    [ ("width", px barWidth)
    , ("height", "3px")
    , ("left", px left)
    , ("top", "34px")
    , ("position", "absolute")
    , ("transition", "left ease 0.5s")
    , ("background-color", "#222")
    ]


komaForStatus : Bool -> Style
komaForStatus player =
  komaShape player 20


points : Style
points =
  [ ("width", "70px")
  , ("height", "20px")
  , ("margin-left", "5px")
  , ("margin-right", "5px")
  ]


row : Style
row =
  [ ("display", "flex")
  ]


cell : Style
cell =
  [ ("width", "40px")
  , ("height", "40px")
  , ("background-color", "#5c5")
  , ("border", "solid 1px #000")
  , ("position", "relative")
  , ("box-sizing", "border-box")
  ]


komaShape : Bool -> Float -> Style
komaShape player size =
  [ ("width", px size)
  , ("height", px size)
  , ("border-style", "solid")
  , ("border-width", if player then "0" else px (size / 2))
  , ("border-color", "#000")
  , ("border-radius", px (size / 2))
  , ("background-color", "#fff")
  , ("box-sizing", "border-box")
  ]


koma : Bool -> Style
koma player =
  [ ("transition", "border-width ease 0.3s")
  , ("position", "absolute")
  , ("top", "5px")
  , ("left", "5px")
  ] ++ komaShape player 30


px : Float -> String
px n =
  toString n ++ "px"

module WS exposing (..)

import Json.Decode as D
import Json.Encode as E
import WebSocket


type Msg
    = PutKoma Bool Int Int


listen : String -> Sub Msg
listen host =
    WebSocket.listen ("ws://" ++ host ++ ":3001") toMsg


send : String -> String -> Cmd msg
send host =
    WebSocket.send ("ws://" ++ host ++ ":3001")


sendValue : String -> E.Value -> Cmd msg
sendValue host =
    send host << E.encode 0


toMsg : String -> Msg
toMsg s =
    case D.decodeString decodeKoma s of
        Ok msg ->
            msg

        Err s ->
            Debug.crash s


decodeKoma : D.Decoder Msg
decodeKoma =
    D.map3 PutKoma
        (D.index 0 D.bool)
        (D.index 1 D.int)
        (D.index 2 D.int)


sendPutKoma : String -> Bool -> Int -> Int -> Cmd msg
sendPutKoma host player rowIndex colIndex =
    sendValue host (E.list [ E.bool player, E.int rowIndex, E.int colIndex ])

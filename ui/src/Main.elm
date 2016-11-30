module Main exposing (main)

import Html exposing (program)
import DrawIt exposing (Model, init, view, update, subscriptions)
import Types exposing (Msg)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

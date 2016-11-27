module Main exposing (main)

import Html exposing (program)
import DrawIt exposing (Model, Msg, init, view, update, subscriptions)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

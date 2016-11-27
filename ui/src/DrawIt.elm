module DrawIt
    exposing
        ( Model
        , Msg
        , init
        , view
        , update
        , subscriptions
        )

{- | -}

import Html exposing (..)


type alias Model =
    { foo : Int
    }


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( { foo = 0 }, Cmd.none )


view : Model -> Html Msg
view model =
    div [] [ text "hej" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

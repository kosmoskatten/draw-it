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
import Html.Attributes as A


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
    viewBoard model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


viewBoard : Model -> Html Msg
viewBoard model =
    table [ A.class "board" ]
        [ tr []
            [ td [ A.class "square active" ] []
            , td [ A.class "square" ] []
            ]
        , tr []
            [ td [ A.class "square" ] []
            , td [ A.class "square" ] []
            ]
        ]

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

import Array exposing (Array, repeat)
import Html exposing (..)
import Html.Attributes as A


type alias Model =
    { image : Image
    }


type Msg
    = NoOp


type Image
    = Image (Array (Array Int))


init : ( Model, Cmd Msg )
init =
    ( { image = blankImage dimensions }, Cmd.none )


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


renderImage : Image -> Html Msg
renderImage (Image rows) =
    table [] []


blankImage : Int -> Image
blankImage dim =
    Image <| repeat dim (repeat dim 0)


dimensions : Int
dimensions =
    3

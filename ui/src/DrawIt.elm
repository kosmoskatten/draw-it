module DrawIt
    exposing
        ( Model
        , init
        , view
        , update
        , subscriptions
        )

{- | -}

import Html exposing (..)
import Html.Lazy exposing (lazy)
import Types exposing (Msg(..), MouseMode(..))
import Image exposing (..)


type alias Model =
    { image : Image
    , mouseMode : MouseMode
    }


init : ( Model, Cmd Msg )
init =
    ( { image = blankImage dimensions
      , mouseMode = Inactive
      }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    div []
        [ lazy renderImage model.image
        , text <|
            if model.mouseMode == Active then
                "Mouse: Active"
            else
                "Mouse: Inactive"
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseDown row col ->
            if checkPixel model.image row col then
                ( { model | mouseMode = Active }, Cmd.none )
            else
                ( { model
                    | image = setPixel model.image row col
                    , mouseMode = Active
                  }
                , Cmd.none
                )

        MouseEnter row col ->
            if
                model.mouseMode
                    == Active
                    && not (checkPixel model.image row col)
            then
                ( { model | image = setPixel model.image row col }, Cmd.none )
            else
                ( model, Cmd.none )

        MouseUp ->
            ( { model | mouseMode = Inactive }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

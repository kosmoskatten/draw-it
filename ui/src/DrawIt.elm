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
import Html.Events as E


type alias Model =
    { board : Board
    , mouseMode : MouseMode
    }


type Msg
    = MouseDownOn Int Int
    | MouseUp
    | NoOp


type Board
    = Board (Array (Array Bool))


type MouseMode
    = Active
    | Inactive


init : ( Model, Cmd Msg )
init =
    ( { board = emptyBoard dimensions
      , mouseMode = Inactive
      }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    div []
        [ renderBoard model.board
        , text <|
            if model.mouseMode == Active then
                "Mouse: Active"
            else
                "Mouse: Inactive"
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseDownOn row col ->
            if isSet model.board row col then
                ( { model | mouseMode = Active }, Cmd.none )
            else
                ( { model
                    | board = setSquare model.board row col
                    , mouseMode = Active
                  }
                , Cmd.none
                )

        MouseUp ->
            ( { model | mouseMode = Inactive }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


renderBoard : Board -> Html Msg
renderBoard (Board rows) =
    table [ A.class "board" ] <| transformIndex renderRow rows


renderRow : Int -> Array Bool -> Html Msg
renderRow row values =
    tr [] <| transformIndex (renderSquare row) values


renderSquare : Int -> Int -> Bool -> Html Msg
renderSquare row col isSet =
    if isSet then
        td [ A.class "square active", E.onMouseDown <| MouseDownOn row col ] []
    else
        td [ A.class "square", E.onMouseDown <| MouseDownOn row col ] []


transformIndex : (Int -> a -> b) -> Array a -> List b
transformIndex transform input =
    goTransform transform input (Array.length input - 1) []


goTransform : (Int -> a -> b) -> Array a -> Int -> List b -> List b
goTransform g input index acc =
    case Array.get index input of
        Just elem ->
            goTransform g input (index - 1) (g index elem :: acc)

        Nothing ->
            acc


setSquare : Board -> Int -> Int -> Board
setSquare (Board board) row col =
    case Array.get row board of
        Just oldRow ->
            Board <| Array.set row (Array.set col True oldRow) board

        Nothing ->
            Board board


emptyBoard : Int -> Board
emptyBoard dim =
    Board <| repeat dim (repeat dim False)


isSet : Board -> Int -> Int -> Bool
isSet (Board rows) row col =
    case Array.get row rows of
        Just row_ ->
            Maybe.withDefault False <| Array.get col row_

        Nothing ->
            False


dimensions : Int
dimensions =
    27

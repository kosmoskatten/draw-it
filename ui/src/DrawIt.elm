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

import Array exposing (Array, repeat, foldr)
import Html exposing (..)
import Html.Attributes as A


type alias Model =
    { board : Board
    }


type Msg
    = NoOp


type Board
    = Board (Array (Array Bool))


init : ( Model, Cmd Msg )
init =
    ( { board = emptyBoard dimensions }, Cmd.none )


view : Model -> Html Msg
view model =
    renderBoard model.board


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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
renderSquare row col active =
    if active then
        td [ A.class "square active" ] []
    else
        td [ A.class "square" ] []


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


emptyBoard : Int -> Board
emptyBoard dim =
    Board <| repeat dim (repeat dim False)


dimensions : Int
dimensions =
    27

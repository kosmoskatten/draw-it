module Image
    exposing
        ( Image
        , blankImage
        , checkPixel
        , setPixel
        , dimensions
        , renderImage
        )

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes as A
import Html.Events as E
import Types exposing (Msg(..), MouseMode(..))


{- Representation of one squared dimensioned image. -}


type Image
    = Image (Array (Array Int))



{- Create a, blank,  square image with the given dimension. -}


blankImage : Int -> Image
blankImage dim =
    Image <| Array.repeat dim (Array.repeat dim 0)



{- Check if a pixel at row col is set (i.e. non zero). -}


checkPixel : Image -> Int -> Int -> Bool
checkPixel (Image rows) row col =
    case Array.get row rows of
        Just row_ ->
            Maybe.withDefault False <|
                (Maybe.map (\n -> n > 0) <| Array.get col row_)

        Nothing ->
            False



{- Set the pixel at row col. -}


setPixel : Image -> Int -> Int -> Image
setPixel (Image rows) row col =
    case Array.get row rows of
        Just row_ ->
            Image <| Array.set row (Array.set col 1 row_) rows

        Nothing ->
            Image rows



{- Default dimension for an image. -}


dimensions : Int
dimensions =
    20



{- Render the image as Html -}


renderImage : Image -> Html Msg
renderImage (Image rows) =
    table
        [ A.class "image"
        , E.onMouseUp MouseUp
        , E.onMouseLeave MouseUp
        ]
    <|
        transformIndex renderRow rows


renderRow : Int -> Array Int -> Html Msg
renderRow row values =
    tr [] <| transformIndex (renderPixel row) values


renderPixel : Int -> Int -> Int -> Html Msg
renderPixel row col value =
    if value > 0 then
        td
            [ A.class "pixel set"
            , E.onMouseDown <| MouseDown row col
            , E.onMouseEnter <| MouseEnter row col
            ]
            []
    else
        td
            [ A.class "pixel unset"
            , E.onMouseDown <| MouseDown row col
            , E.onMouseEnter <| MouseEnter row col
            ]
            []


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

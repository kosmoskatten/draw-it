module Types exposing (Msg(..), MouseMode(..))


type Msg
    = MouseDown Int Int
    | MouseEnter Int Int
    | MouseUp
    | NoOp


type MouseMode
    = Active
    | Inactive

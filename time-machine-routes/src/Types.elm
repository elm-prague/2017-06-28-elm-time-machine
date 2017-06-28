module Types exposing (..)

import Time exposing (Time)
import Toast exposing (Toast)

type alias Realities =
    { red: Reality
    , green: Reality
    , blue: Reality
    }

type alias Reality =
    { description: String
    , actionA: String
    , actionB: String
    , result: String
    }
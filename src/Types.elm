module Types exposing (..)

import Time exposing (Time)
import Toast exposing (Toast)

type alias AppNotification =
    { message : String
    , important : Bool
    }

type alias NotificationExt a =
    { a
    | toast : Toast AppNotification
    , time : Time
    }


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
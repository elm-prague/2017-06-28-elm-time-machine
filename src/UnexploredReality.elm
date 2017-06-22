module UnexploredReality exposing (Model, init, Msg, update, view, setReality)

import Html
import Html exposing (Html, div, text, p, h1)
import Routes exposing (linkTo, Route(Home))
import Types exposing (..)

--- MODEL ---

type alias Model =
    { realities: Realities
    , reality: Maybe Reality
    }


type Msg =
    DefaultMsg

init : Realities -> Model
init realities =
    Model realities Nothing

--- UPDATE ---

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            DefaultMsg ->
                model ! []

setReality : String -> Model -> Model
setReality name model =
    if name == "Red" then
        { model
        | reality = Just model.realities.red
        }
    else if name == "Green" then
        { model
        | reality = Just model.realities.green
        }
    else
        { model
        | reality = Just model.realities.blue
        }

--- VIEW ---

view : Model -> Html Msg
view model =
    let
        realityText =
            case model.reality of
                Nothing ->
                    "Unknown reality"
                Just val ->
                    val.description
    in
    div []
        [ h1 [] [ text "Time control page" ]
        , p [] []
        , text realityText
        , p [] []
        , Routes.linkTo Routes.Home
            [] [ text "I miss home" ]
        ]

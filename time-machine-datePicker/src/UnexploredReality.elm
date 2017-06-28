module UnexploredReality exposing (Model, init, Msg(..), update, view, setReality)

import Html
import Html exposing (Html, div, text, p, h1, button)
import Html.Events exposing (onClick)
import Routes exposing (linkTo, Route(Home))
import Types exposing (..)

--- MODEL ---

type alias Model =
    { realities: Realities
    , reality: Maybe Reality
    , date : String
    }


type Msg =
    DefaultMsg

init : Realities -> Model
init realities =
    Model realities Nothing ""

--- UPDATE ---

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            DefaultMsg ->
                model ! []

setReality : String -> String -> Model -> Model
setReality name date model =
    if name == "Red" then
        { model
        | reality = Just model.realities.red
        , date = date
        }
    else if name == "Green" then
        { model
        | reality = Just model.realities.green
        , date = date
        }
    else
        { model
        | reality = Just model.realities.blue
        , date = date
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

        actionAText =
            printActionA model.reality

        actionBText =
            printActionB model.reality
    in
    div []
        [ h1 [] [ text "Time control page" ]
        , text ("You moved in time to: " ++ model.date)
        , p [] []
        , text realityText
        , p [] []
        ]

printActionA : Maybe Reality -> String
printActionA reality =
    case reality of
        Nothing ->
            "Unknown action"
        Just val ->
            val.actionA

printActionB : Maybe Reality -> String
printActionB reality =
    case reality of
        Nothing ->
            "Unknown action"
        Just val ->
            val.actionB
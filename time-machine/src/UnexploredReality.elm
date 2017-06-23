module UnexploredReality exposing (Model, init, Msg(..), update, view, setReality, viewDialog, viewDialogFooter, viewDialogHeader)

import Html
import Html exposing (Html, div, text, p, h1, button)
import Html.Events exposing (onClick)
import Routes exposing (linkTo, Route(Home))
import Types exposing (..)

--- MODEL ---

type alias Model =
    { realities: Realities
    , reality: Maybe Reality
    , showDialog: Bool
    , performedAction: String
    }


type Msg =
    DefaultMsg
    | ShowDialog String
    | CloseDialog

init : Realities -> Model
init realities =
    Model realities Nothing False ""

--- UPDATE ---

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            DefaultMsg ->
                model ! []

            ShowDialog str ->
                { model
                | showDialog = True
                , performedAction = str
                } ! []

            CloseDialog ->
                { model
                | showDialog = False
                } ! []


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

        actionAText =
            printActionA model.reality

        actionBText =
            printActionB model.reality
    in
    div []
        [ h1 [] [ text "Time control page" ]
        , p [] []
        , text realityText
        , p [] []
        , button [onClick <| ShowDialog actionAText] [ text actionAText ]
        , button [onClick <| ShowDialog actionBText] [ text actionBText ]
        , p [] []
        ]

viewDialog : Model -> Html Msg
viewDialog model =
    let
        resultText =
            case model.reality of
                Nothing ->
                    "Unknown result"
                Just reality ->
                    reality.result
    in
        text resultText

viewDialogHeader : Model -> Html Msg
viewDialogHeader model =
    text <| "You performed "++ model.performedAction

viewDialogFooter : Model -> Html Msg
viewDialogFooter model =
    Routes.linkTo Routes.Home
        [] [ text "I miss home" ]

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
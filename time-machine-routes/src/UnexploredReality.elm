module UnexploredReality exposing (Model, init, Msg(..), update, view)

import Html
import Html exposing (Html, div, text, p, h1, button)

--- MODEL ---

type alias Model =
    ()


init : Model
init =
    ()

type Msg =
    DefaultMsg

--- UPDATE ---

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            DefaultMsg ->
                model ! []

--- VIEW ---

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Unexpected reality page" ]
        , p [] []
        ]


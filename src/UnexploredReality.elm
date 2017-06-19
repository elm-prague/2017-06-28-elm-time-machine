module UnexploredReality exposing (Model, init, Msg, update, view)

import Html
import Html exposing (Html, div, text, p, h1)
import Routes exposing (linkTo, Route(Home))

--- MODEL ---

type alias Model =
    {
    }


type Msg =
    DefaultMsg

init : Model
init =
    Model

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
        [ h1 [] [ text "Time control page" ]
        , p [] []
        , text "Some actions in dialog"
        , p [] []
        , Routes.linkTo Routes.Home
            [] [ text "I miss home" ]
        ]

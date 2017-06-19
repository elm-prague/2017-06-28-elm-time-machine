module TimeControl exposing (Model, init, Msg, update, view)

import Html exposing (Html, div, text, h1, p)
import Routes exposing (linkTo, Route(UnexploredRealityPage))

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
            , text "Choose the time where do you want to go. Please be patient 'cause I'm limited by datePicker capabilities."
            , p [] []
            , text "datePicker"
            , text "parallel reality might be chosen randomly or by radio buttons"
            , p [] []
            , Routes.linkTo (Routes.UnexploredRealityPage "Type of reality")
                [] [ text "No fear" ]
            ]
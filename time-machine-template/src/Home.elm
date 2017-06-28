module Home exposing (Model, init, Msg, update, view)

import Html exposing (Html, div, h1, p, text)

type alias Model =
    ()


init : Model
init =
    ()


type Msg
    = Show


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show ->
            ( model, Cmd.none )

------ VIEW ------

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Home page" ]
        ]

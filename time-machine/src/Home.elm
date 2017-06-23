module Home exposing (Model, init, Msg, update, view)

import Html exposing (Html, div, text, p, h1)
import Routes exposing (linkTo, Route(TimeControlPage))


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
        , text "You've just build your own Time machine!!!1111"
        , p [] []
        , text "Press start if you want to test it."
        , p [] []
        , Routes.linkTo Routes.TimeControlPage
            [] [ text "Start" ]
        ]

module Main exposing (..)

import Html exposing (programWithFlags)
import Html exposing (Html, header, div, ul, text)
import Html.Attributes exposing (class)

main : Program Flags Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Flags =
    {}

type alias Model =
    { }

type Msg =
    Show

init : Model -> ( Model, Cmd Msg )
init model =
    model ! []

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show ->
            model ! []

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

------ VIEW ------

view : Model -> Html Msg
view model =
    div
        [ class "container-fluid"
        ]
        [ menu model
        ]


menu : Model -> Html Msg
menu model =
    header [ class "navbar navbar-default" ]
        [ div [ class "container" ]
            [ ul [ class "nav navbar-nav" ]
                [ div [ class "navbar-brand" ]
                    [ text "Home"
                    ]
                ]
            , ul [ class "nav navbar-nav" ]
                [ div [ class "navbar-brand" ]
                    [ text "Welcome, time traveller!"
                    ]
                ]
            ]
        ]

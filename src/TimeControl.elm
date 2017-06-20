module TimeControl exposing (Model, init, Msg(..), update, view)

import Html exposing (Html, div, text, h1, p)
import Routes exposing (linkTo, Route(UnexploredRealityPage))
import DatePicker exposing (DatePicker, defaultSettings, DateEvent(..))
import Date exposing (Date)

--- MODEL ---

type alias Model =
    { datePicker: DatePicker.DatePicker
    , pickedDate: Maybe Date
    }


type Msg =
    DefaultMsg
    | SetDatePicker DatePicker.Msg

init : DatePicker -> Model
init picker =
    Model picker Nothing


--- UPDATE ---

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            DefaultMsg ->
                model ! []

            SetDatePicker msg ->
                let
                    ( newDatePicker, datePickerCmd, dateEvent ) =
                        DatePicker.update defaultSettings msg model.datePicker

                    date =
                        case dateEvent of
                            NoChange ->
                                model.pickedDate

                            Changed newDate ->
                                newDate
                in
                    { model
                        | pickedDate = date
                        , datePicker = newDatePicker
                    }
                        ! [ Cmd.map SetDatePicker datePickerCmd ]

--- VIEW ---

view : Model -> Html Msg
view model =
    div []
            [ h1 [] [ text "Time control page" ]
            , text "Choose the time where do you want to go. Please be patient 'cause I'm limited by datePicker capabilities."
            , p [] []
            , DatePicker.view
                  model.pickedDate
                  defaultSettings
                  model.datePicker
               |> Html.map SetDatePicker
            , p [] []
            , text "parallel reality might be chosen randomly or by radio buttons"
            , p [] []
            , Routes.linkTo (Routes.UnexploredRealityPage "Type of reality")
                [] [ text "No fear" ]
            ]
module TimeControl exposing (Model, init, Msg(..), update, view, subscriptions)

import Html exposing (Html, div, text, h1, p, input, label, select, fieldset, br)
import Html.Attributes exposing (value, type_, checked, class)
import Html.Events exposing (onClick)
import Routes exposing (linkTo, Route(UnexploredRealityPage))
import DatePicker exposing (DatePicker, defaultSettings, DateEvent(..))
import Date exposing (Date, year, month, day)
import Time exposing (Time)
import NotificationHelper exposing (subscriptions, updateNotificationTime)
import Toast exposing (Toast)
import Types exposing (..)

--- MODEL ---

type alias Model =
    { datePicker: DatePicker.DatePicker
    , pickedDate: Maybe Date
    , color: Color
    , time: Time
    , toast : Toast AppNotification
    }


type Msg =
    SetDatePicker DatePicker.Msg
    | SelectColor Color
    | Tick Time

type Color =
    Red
    | Blue
    | Green

init : DatePicker -> Time -> Model
init picker time =
    Model picker Nothing Red time NotificationHelper.initToast


subscriptions : Model -> Sub Msg
subscriptions model =
    NotificationHelper.subscriptions model Tick

--- UPDATE ---

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
                    case dateEvent of
                        NoChange ->
                            { model
                            | pickedDate = date
                            , datePicker = newDatePicker
                            } ! [ Cmd.map SetDatePicker datePickerCmd ]
                        Changed c ->
                            ({ model
                            | pickedDate = date
                            , datePicker = newDatePicker
                            } |> NotificationHelper.postNotification (AppNotification "Time machine has started (powered by plutonium stolen from Libyan terrorists)" False))
                                ! [ Cmd.map SetDatePicker datePickerCmd ]

            SelectColor color ->
                { model
                | color = color
                } ! []
            Tick newTime ->
                ( NotificationHelper.updateNotificationTime model newTime
                , Cmd.none
                )

--- VIEW ---

view : Model -> Html Msg
view model =
    div []
            [ h1 [] [ text "Time control page" ]
            , NotificationHelper.notificationsView model.toast model.time
            , text "Choose the time where do you want to go. Please be patient 'cause I'm limited by datePicker capabilities."
            , p [] []
            , DatePicker.view
                  model.pickedDate
                  defaultSettings
                  model.datePicker
               |> Html.map SetDatePicker
            , div [class "bot-pad"] [ text "" ]
            , text "There are three switches with different colours, which one will you select?"
            , p [] []
            , viewOptions model
            , p [] []
            , Routes.linkTo (Routes.UnexploredRealityPage (printColor model.color) (printDate model.pickedDate))
                [] [ text "No fear" ]
            ]

viewOptions: Model -> Html Msg
viewOptions model =
     fieldset []
            [ radio Red model.color
            , radio Blue model.color
            , radio Green model.color
            ]

radio : Color -> Color -> Html Msg
radio radioColor selectedColor =
  let
    isSelected =
        if radioColor == selectedColor then
            checked True
        else
            checked False
  in
  div []
    [ label []
        [ input [ type_ "radio", onClick (SelectColor radioColor), isSelected ] []
        , text (printColor radioColor)
        ]
    ]

printColor : Color -> String
printColor color =
    case color of
        Red ->
            "Red"
        Green ->
            "Green"
        Blue ->
            "Blue"

printDate : Maybe Date -> String
printDate date =
    case date of
        Nothing ->
            "01-01-1200"
        Just date ->
            let
                yearStr =
                    toString (year date)
                monthStr =
                    toString (month date)
                dayStr =
                    toString (day date)
            in
                dayStr ++ "-" ++ monthStr ++ "-" ++ yearStr
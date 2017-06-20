module TimeControl exposing (Model, init, Msg(..), update, view)

import Html exposing (Html, div, text, h1, p, input, label, select, fieldset, br)
import Html.Attributes exposing (value, type_, checked, class)
import Html.Events exposing (onClick)
import Routes exposing (linkTo, Route(UnexploredRealityPage))
import DatePicker exposing (DatePicker, defaultSettings, DateEvent(..))
import Date exposing (Date)

--- MODEL ---

type alias Model =
    { datePicker: DatePicker.DatePicker
    , pickedDate: Maybe Date
    , color: Color
    }


type Msg =
    DefaultMsg
    | SetDatePicker DatePicker.Msg
    | SelectColor Color

type Color =
    Red
    | Blue
    | Green

init : DatePicker -> Model
init picker =
    Model picker Nothing Red


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

            SelectColor color ->
                { model
                | color = color
                } ! []

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
            , div [class "bot-pad"] [ text "" ]
            , text "There are three switches with different colours, which one will you select?"
            , p [] []
            , viewOptions model
            , p [] []
            , Routes.linkTo (Routes.UnexploredRealityPage <| printColor model.color)
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
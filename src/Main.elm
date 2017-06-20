module Main exposing (..)

import TimeControl exposing (Msg(..))
import UnexploredReality
import Home
import Routes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html
import Navigation
import DatePicker exposing (DatePicker)
import Date exposing (Day(..))

main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { route : Routes.Route
    , homeModel : Home.Model
    , timeControlModel : TimeControl.Model
    , unexploredRealityModel : UnexploredReality.Model
    }


type Msg
    = HomeMsg Home.Msg
    | TimeControlMsg TimeControl.Msg
    | UnexploredRealityMsg UnexploredReality.Msg
    | Navigate String
    | UrlChange Navigation.Location


initialModel : DatePicker -> Model
initialModel picker =
    { route = Home
    , homeModel = Home.init
    , timeControlModel = TimeControl.init picker
    , unexploredRealityModel = UnexploredReality.init
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init loc =
    let
        ( datePicker, datePickerCmd ) =
            DatePicker.init
        ( updatedModel, cmd ) =
            update (UrlChange loc) (initialModel datePicker)
    in
        updatedModel !
            [ cmd
            , Cmd.map TimeControlMsg <| Cmd.map SetDatePicker datePickerCmd
            ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg m ->
            let
                ( subMdl, subCmd ) =
                    Home.update m model.homeModel
            in
                { model | homeModel = subMdl }
                    ! [ Cmd.map HomeMsg subCmd ]

        TimeControlMsg m ->
            let
                ( subMdl, subCmd ) =
                    TimeControl.update m model.timeControlModel
            in
                { model | timeControlModel = subMdl }
                    ! [ Cmd.map TimeControlMsg subCmd ]

        UnexploredRealityMsg m ->
            let
                ( subMdl, subCmd ) =
                    UnexploredReality.update m model.unexploredRealityModel
            in
                { model | unexploredRealityModel = subMdl }
                    ! [ Cmd.map UnexploredRealityMsg subCmd ]

        UrlChange loc ->
            urlUpdate loc model

        Navigate url ->
            model ! [ Navigation.newUrl url ]


urlUpdate : Navigation.Location -> Model -> ( Model, Cmd Msg )
urlUpdate loc model =
    case (Routes.decode loc) of
        Nothing ->
            model ! [ Navigation.modifyUrl (Routes.encode model.route) ]

        {-Just (TimeControlPage as route) ->
            { model | route = route }
                ! [ Cmd.map TimeControlMsg <| TimeControl.someInitialCmd ]

        Just ((UnexploredRealityPage realityId) as route) ->
            { model | route = route }
                ! [ Cmd.map UnexploredRealityMsg <| UnexploredReality.someInitialCmd ]-}

        Just route ->
            { model | route = route } ! []

------ VIEW ------

view : Model -> Html Msg
view model =
    div
        [ class "container-fluid"
        , Routes.catchNavigationClicks Navigate
        ]
        [ menu model
        , div [ class "content" ]
            [ contentView model ]
        ]


menu : Model -> Html Msg
menu model =
    header [ class "navbar navbar-default" ]
        [ div [ class "container" ]
            [ ul [ class "nav navbar-nav" ]
                [ div [ class "navbar-brand" ]
                    [ Routes.linkTo Routes.Home
                        []
                        [ text "Home" ]
                    ]
                ]
            , ul [ class "nav navbar-nav" ]
                [ div [ class "navbar-brand" ]
                    [ text "Welcome, time traveller!"
                    ]
                ]
            ]
        ]


contentView : Model -> Html Msg
contentView model =
    case model.route of
        Home ->
            Html.map HomeMsg <| Home.view model.homeModel

        TimeControlPage ->
            Html.map TimeControlMsg <| TimeControl.view model.timeControlModel

        UnexploredRealityPage i ->
            Html.map UnexploredRealityMsg <| UnexploredReality.view model.unexploredRealityModel
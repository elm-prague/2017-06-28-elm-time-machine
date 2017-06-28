module Routes exposing (..)

import UrlParser exposing (Parser, (</>), string, oneOf, s)
import Navigation exposing (Location)
import Html.Attributes exposing (href, attribute)
import Html exposing (Html, Attribute, a)
import Html.Events exposing (onWithOptions)
import Json.Decode as Json


type Route
    = Home
    | TimeControlPage
    | UnexploredRealityPage String String


routeParser : Parser (Route -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home (s "")
        , UrlParser.map TimeControlPage (s "time-control")
        , UrlParser.map UnexploredRealityPage (s "unexplored-reality" </> string </> string )
        ]


decode : Location -> Maybe Route
decode location =
    UrlParser.parsePath routeParser location

encode : Route -> String
encode route =
    case route of
        Home ->
            "/"

        TimeControlPage ->
            "/time-control"

        UnexploredRealityPage i j ->
            "/unexplored-reality/" ++ i ++ "/" ++ j

linkTo : Route -> List (Attribute msg) -> List (Html msg) -> Html msg
linkTo route attrs content =
    a ((linkAttrs route) ++ attrs) content


linkAttrs : Route -> List (Attribute msg)
linkAttrs route =
    let
        path =
            encode route
    in
        [ href path
        , attribute "data-navigate" path
        ]
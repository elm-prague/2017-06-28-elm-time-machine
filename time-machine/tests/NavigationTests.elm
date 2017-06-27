module NavigationTests exposing (..)

import Test exposing (..)
import Expect
import Navigation exposing (Location)
import Routes exposing (decode, encode, Route(..))
import Html exposing (Html, a)
import Html.Attributes exposing (href, attribute)

location1 : Location
location1 =
    { href = "http://localhost:8080/module/submodule"
    , host = "localhost:8080"
    , hostname = "localhost"
    , protocol ="http"
    , origin = "http://localhost:8080"
    , port_ = "8080"
    , pathname = "/module/submodule"
    , search = ""
    , hash = ""
    , username = ""
    , password = ""
    }

location2 : Location
location2 =
    { href = "http://localhost:8080/"
    , host = "localhost:8080"
    , hostname = "localhost"
    , protocol ="http"
    , origin = "http://localhost:8080"
    , port_ = "8080"
    , pathname = "/"
    , search = ""
    , hash = ""
    , username = ""
    , password = ""
    }

location3 : Location
location3 =
    { href = "http://localhost:8080/unexplored-reality/1"
    , host = "localhost:8080"
    , hostname = "localhost"
    , protocol ="http"
    , origin = "http://localhost:8080"
    , port_ = "8080"
    , pathname = "/unexplored-reality/1"
    , search = ""
    , hash = ""
    , username = ""
    , password = ""
    }

linkToUnexploredReality : String -> Html msg
linkToUnexploredReality reality =
    let
        path = "/unexplored-reality/" ++ reality
    in
        a
        [ href path
        , attribute "data-navigate" path
        ] []

decodeNavigationUnits : Test
decodeNavigationUnits =
    describe "Decode Navigation Unit tests"
        [ describe "Test nonexisting location decoding"
            [ test "http://localhost:8080/module/submodule" <|
                \_ ->
                    Expect.equal (Routes.decode location1) Nothing
            ]
        , describe "Test existing location decoding"
                      [ test "http://localhost:8080/" <|
                          \_ ->
                              Expect.equal (Routes.decode location2) (Just Routes.Home)
                      , test "http://localhost:8080/unexplored-reality/1" <|
                          \() ->
                              Expect.equal (Routes.decode location3) (Just <| Routes.UnexploredRealityPage "1")
                      , test "http://localhost:8080/unexplored-reality/2" <|
                              \() ->
                                  Expect.notEqual (Routes.decode location3) (Just <| Routes.UnexploredRealityPage "2")
                      ]
        ]

encodeNavigationUnits : Test
encodeNavigationUnits =
    describe "Encode Navigation Unit tests"
        [ describe "Test location encoding"
            [ test "Home" <|
                \_ ->
                    Expect.equal (Routes.encode Routes.Home) "/"
            , test "Unexplored reality" <|
                \_ ->
                    let
                        path = "butterfly-effect"
                    in
                        Expect.equal (Routes.encode <| Routes.UnexploredRealityPage path) ("/unexplored-reality/" ++ path)
            ]
        ]

linkHtmlUnits : Test
linkHtmlUnits =
    describe "Link View Unit tests"
        [ test "Link to Unexplored reality page" <|
            \_ ->
                let
                    path = "butterfly-effect"
                in
                Expect.equal (Routes.linkTo (Routes.UnexploredRealityPage path) [] []) (linkToUnexploredReality path)
        ]
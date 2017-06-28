import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)
import RemoteData exposing (RemoteData(..), WebData)
import Http exposing (get)
import Json.Decode as JsonD exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, requiredAt, required, hardcoded, optional)
import Json.Decode as JsonD

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

init : ( Model, Cmd Msg )
init =
    ({

    }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MODEL

type alias Dinosaur =
    { name : String
    , armLength : Int
    , wayToKill : String
    }

type alias KillerBunny =
    { teethCount : Int
    , wayToKill : String
    }

type alias Model =
    {
    }

-- UPDATE

type Msg = LoadTRex

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LoadTRex ->
       model
      ! []

tRexDecoder : JsonD.Decoder Dinosaur
tRexDecoder =
    decode Dinosaur
        |> required "name" JsonD.string
        |> required "armLength" JsonD.int
        |> required "wayToKill" JsonD.string

bunnyDecoder : JsonD.Decoder KillerBunny
bunnyDecoder =
    decode KillerBunny
        |> required "teethCount" JsonD.int
        |> required "wayToKill" JsonD.string

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ p [] []
    , button [onClick LoadTRex] [ text "Load T-REX"]
    , p [] []
--    , button [onClick LoadBunny] [ text "Load bunny"]
--    , p [] []
--    , text "T-REX: "
--    , printAnimalWebData model.tRex
--    , p [] []
--    , text "Bunny: "
--    , printAnimalWebData model.bunny
    ]
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
    ({tRex = NotAsked, bunny = NotAsked}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MODEL

type alias DangerousAnimal a =
    { a
    | wayToKill : String
    }

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
    { tRex : WebData Dinosaur
    , bunny : WebData KillerBunny
    }

-- UPDATE

type Msg = LoadTRex
         | LoadBunny
         | TRexLoaded (WebData Dinosaur)
         | BunnyLoaded (WebData KillerBunny)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LoadTRex ->
      { model
      | tRex = Loading
      } ! [getTRex]

    LoadBunny ->
      { model
        | bunny = Loading
        } ! [getBunny]

    TRexLoaded val ->
      { model
      | tRex = val
      } ! []

    BunnyLoaded val ->
      { model
      | bunny = val
      } ! []





getTRex : Cmd Msg
getTRex =
    get "http://localhost:8200/dinosaur" tRexDecoder
        |> RemoteData.sendRequest
        |> Cmd.map TRexLoaded

tRexDecoder : JsonD.Decoder Dinosaur
tRexDecoder =
    decode Dinosaur
        |> required "name" JsonD.string
        |> required "armLength" JsonD.int
        |> required "wayToKill" JsonD.string


getBunny : Cmd Msg
getBunny =
    get "http://localhost:8200/bunny" bunnyDecoder
        |> RemoteData.sendRequest
        |> Cmd.map BunnyLoaded

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
    , button [onClick LoadBunny] [ text "Load bunny"]
    , p [] []
    , text "T-REX: "
    , printAnimalWebData model.tRex
    , p [] []
    , text "Bunny: "
    , printAnimalWebData model.bunny
    ]

printAnimalWebData : WebData (DangerousAnimal a) -> Html msg
printAnimalWebData animal =
    case animal of
        NotAsked ->
            text "There is no animal"

        Loading ->
            text "Animal is loading"

        Failure err ->
            text <| "Error loading animal: "++ toString err

        Success val ->
            text <| printWayToKill val

printWayToKill : DangerousAnimal a -> String
printWayToKill animal =
    animal.wayToKill
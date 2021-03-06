module Main exposing (..)

import Counter
import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)


main =
    App.beginnerProgram
        { model = init 0 0
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { topCounter : Counter.Model
    , bottomCounter : Counter.Model
    }


init : Int -> Int -> Model
init top bottom =
    { topCounter = Counter.init top
    , bottomCounter = Counter.init bottom
    }



-- UPDATE


type Msg
    = Reset
    | Top Counter.Msg
    | Bottom Counter.Msg
    | Add2
    | Swap


update : Msg -> Model -> Model
update message model =
    case message of
        Reset ->
            init 0 0

        Top msg ->
            { model | topCounter = Counter.update msg model.topCounter }

        Bottom msg ->
            { model | bottomCounter = Counter.update msg model.bottomCounter }

        Add2 ->
            { model | topCounter = model.topCounter + 2 }

        Swap ->
            let
                oldTop =
                    model.topCounter
            in
                { model | topCounter = model.bottomCounter, bottomCounter = oldTop }



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ App.map Top (Counter.view model.topCounter)
        , App.map Bottom (Counter.view model.bottomCounter)
        , button [ onClick Reset ] [ text "RESET" ]
        , button [ onClick Add2 ] [ text "ADD 2 TO TOP" ]
        , button [ onClick Swap ] [ text "SWITCH THE COUNTERS" ]
        ]

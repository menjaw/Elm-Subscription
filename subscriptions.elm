-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/time.html
module Main exposing (..)
import Html exposing (Html, div, text, program)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (every, millisecond, Time, second)
import Mouse



--
-- Exercise 3
-- This exercise is about responding to subscriptions at a fixed interval
-- Your job is to
-- 1: Start a subscription every millisecond
-- 2: Update the model when the subscription arrive in the update functions
-- 3: Set the width of the second progress-bar in the view (by correctly
--    updating the 'progress' variable in line 51) to go from 0 to 100 once
--    every 5 seconds. It should start with a width of 0 pixels and during the
--    next 50 millisecond grow to a width of 1 and so on. When 5000 milliseconds
--    have passed the width should reset to 0.
--

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL
type alias Model = Time

init : (Model, Cmd Msg)
init =
  (0, Cmd.none)

-- UPDATE
type Msg
  = Tick Time
  | MouseMsg Mouse.Position

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick newTime ->
            (newTime, Cmd.none)

        MouseMsg position ->
            (model + 1, Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [
    Time.every millisecond Tick -- runs in millisecond (here you can change to another time-type (second, minutes etc))
    ,Mouse.clicks MouseMsg -- everytime you click with the mouse it increased the subscription
    ]

-- VIEW
view : Model -> Html Msg
view model =
  let
    progress = "0"

    angle =
      turns (Time.inMinutes model)

    handX =
      toString (50 + 40 * cos angle)

    handY =
      toString (50 + 40 * sin angle)


 in
    svg [ viewBox "0 0 120 120", width "500px" ]
      [ rect [x "10", y "10", width "100", height "6", rx "2", ry "2" ] []
      , rect [x "10", y "10", width progress, height "6", rx "2", ry "2", fill "#AAA"] []
      , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] [] -- placed a line to show the runtime in milliseconds
      ]



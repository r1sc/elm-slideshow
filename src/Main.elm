module Main exposing (main)

import Html exposing (..)
import Http
import Markdown
import Slide exposing (Slide)
import Requests
import Keyboard
import Style
import Point exposing (Point)
import Array


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { slides : Array.Array Slide
    , currentSlideIndex : Int
    }


type Msg
    = Noop
    | NewSlides (Result Http.Error (List Slide))
    | KeyPressed Keyboard.KeyCode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        NewSlides (Ok slides) ->
            ( { model | slides = (Array.fromList slides) }, Cmd.none )

        NewSlides (Err _) ->
            ( model, Cmd.none )

        KeyPressed keyCode ->
            case keyCode of
                39 ->
                    --Right
                    ( { model | currentSlideIndex = (model.currentSlideIndex + 1) }, Cmd.none )

                37 ->
                    --Left
                    ( { model | currentSlideIndex = (model.currentSlideIndex - 1) }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    let
        currentSlide =
            Array.get model.currentSlideIndex model.slides

        cameraPos =
            case currentSlide of
                Just slide ->
                    slide.position

                Nothing ->
                    Point 0 0
    in
        div [ Style.outer cameraPos ]
            [ div [ Style.container cameraPos ]
                (List.map
                    renderSlide
                    (Array.toList model.slides)
                )
            ]


renderSlide : Slide -> Html Msg
renderSlide slide =
    let
        body =
            slide.body
    in
        div [ Style.slide slide.position ] [ Markdown.toHtml [] body ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.downs KeyPressed


init : ( Model, Cmd Msg )
init =
    ( Model Array.empty 0, Requests.getSlides NewSlides )

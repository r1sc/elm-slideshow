module Requests exposing (getSlides)

import Slide exposing (Slide, decodeSlides)
import Http


getSlides : (Result Http.Error (List Slide) -> msg) -> Cmd msg
getSlides mapper =
    Http.get "/slides.json" decodeSlides
        |> Http.send mapper

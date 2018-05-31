module Slide exposing (Slide, decodeSlides)

import Json.Decode as Decode
import Point exposing (Point)


type alias Slide =
    { position : Point
    , body : String
    }


decodeSlide : Decode.Decoder Slide
decodeSlide =
    Decode.map2 Slide
        (Decode.map2 Point
            (Decode.at [ "pos", "x" ] Decode.float)
            (Decode.at [ "pos", "y" ] Decode.float)
        )
        (Decode.field "body" Decode.string)


decodeSlides : Decode.Decoder (List Slide)
decodeSlides =
    Decode.field "slides" (Decode.list decodeSlide)

module Style exposing (container, slide, outer)

import Html exposing (Attribute)
import Html.Attributes exposing (style)
import Point exposing (Point)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


pointToTranslate : Point -> String
pointToTranslate point =
    "translate(" ++ (toString point.x) ++ "px," ++ (toString point.y) ++ "px)"


negate : Point -> Point
negate point =
    Point -point.x -point.y


outer : Point -> Html.Attribute msg
outer cameraPosition =
    style
        [ "overflow" => "hidden"
        , "width" => "100%"
        , "height" => "100%"
        , "background" => "url(/cork.jpg) repeat repeat"
        , "background-position" => ((toString -cameraPosition.x) ++ "px " ++ (toString -cameraPosition.y) ++ "px")
        , "transition" => "2s"
        ]


container : Point -> Html.Attribute msg
container cameraPosition =
    style
        [ "transition" => "2s"
        , "transform" => (pointToTranslate (negate cameraPosition))
        , "font-size" => "38px"
        , "font-family" => "monospace"
        , "display" => "block"
        ]


slide : Point -> Html.Attribute msg
slide position =
    style
        [ "transform" => (pointToTranslate position)
        , "position" => "absolute"
        , "background" => "white"
        , "padding" => "50px"
        , "margin" => "20px"
        , "box-shadow" => "0px 5px 10px 2px rgba(0,0,0,0.3)"
        ]

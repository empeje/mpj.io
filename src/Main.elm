module Main exposing (..)

import Browser
import Html exposing (Html, a, div, h1, h2, img, li, p, text, ul)
import Html.Attributes exposing (href, src, target)



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "https://github.com/empeje.png" ] []
        , h1 [] [ text "Welcome!" ]
        , p [] [ text "I'm mpj, a software engineer and tech creator living in Indonesia. I'm a big fan of Rocket Raccoon." ]
        , viewBlogs
        , viewTalks
        , viewCompanies
        ]


viewBlogs : Html Msg
viewBlogs =
    div []
        [ h2 [] [ text "Talks" ]
        , p [] [ text "I write blogs on various platforms, here are links to places where I write tech stuff." ]
        , ul []
            [ li [] [ linkNewTab [ href "https://www.codementor.io/@amappuji/" ] [ text "mpj @Codementor" ] ]
            , li [] [ linkNewTab [ href "https://medium.com/@empeje" ] [ text "mpj @Medium" ] ]
            , li [] [ linkNewTab [ href "https://twitter.com/@mpj_rocket" ] [ text "mpj @Twitter" ] ]
            ]
        ]


viewTalks : Html Msg
viewTalks =
    div []
        [ h2 [] [ text "Talks" ]
        , p [] [ text "Occasionally, I speak in various tech events, these are my recent talks." ]
        , ul []
            [ li [] [ linkNewTab [ href "https://www.youtube.com/watch?v=jFP_ompB0vs" ] [ text "2018. MoodleMoot Philippines. Deploy Moodle in Raspberry Pi with Docker & Remote" ] ]
            , li [] [ linkNewTab [ href "https://www.youtube.com/watch?v=kTeUuLXzwzk" ] [ text "2018. DevOpsDay Jakarta. DevOps practice in nonprofit" ] ]
            , li [] [ linkNewTab [ href "https://www.youtube.com/watch?v=hLw0WZQajUo" ] [ text "2017. PyCon Indonesia. Playful Load Testing with Locust" ] ]
            ]
        ]


viewCompanies : Html Msg
viewCompanies =
    div []
        [ h2 [] [ text "Companies" ]
        , p [] [ text "I really interested in entrepreneurial activities, and in 2020 despite the pandemic, I manage to start one. Here are some companies I actively working on" ]
        , ul []
            [ li [] [ linkNewTab [ href "https://kulkul.tech/" ] [ text "Kulkul Tech" ] ]
            , li [] [ linkNewTab [ href "https://084soft.com/" ] [ text "084Soft" ] ]
            ]
        ]


linkNewTab : List (Html.Attribute msg) -> List (Html msg) -> Html msg
linkNewTab attrs children =
    a (List.append [ target "_blank" ] attrs) children



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }

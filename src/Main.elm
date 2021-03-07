module Main exposing (..)

import Browser
import Html exposing (Html, a, div, h1, h2, img, p, text)
import Html.Attributes exposing (class, href, src, target)



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
    div [ class "container content" ]
        [ viewHeader
        , viewBlogs
        , viewTalks
        , viewCompanies
        , viewFooter
        ]


viewHeader : Html Msg
viewHeader =
    div []
        [ img [ class "logo", src "https://github.com/empeje.png" ] []
        , h1 [] [ text "Welcome!" ]
        , p [] [ text "I'm mpj, a software engineer and tech creator living in Indonesia. I'm a big fan of Rocket Raccoon." ]
        ]


viewBlogs : Html Msg
viewBlogs =
    let
        data =
            [ ( "https://www.codementor.io/@amappuji/", "mpj @Codementor" )
            , ( "https://medium.com/@empeje", "mpj @Medium" )
            , ( "https://twitter.com/@mpj_rocket", "mpj @Twitter" )
            ]
    in
    List.append
        [ h2 [] [ text "Blogs" ]
        , p [] [ text "I write blogs on various platforms, here are links to places where I write tech stuff." ]
        ]
        (viewList data)
        |> div []


viewTalks : Html Msg
viewTalks =
    let
        data =
            [ ( "https://www.youtube.com/watch?v=gHi4l1N62wc", "2020. SabernX. Intro to Social Coding with Git & GitHub (In Bahasa)" )
            , ( "https://www.youtube.com/watch?v=jFP_ompB0vs", "2018. MoodleMoot Philippines. Deploy Moodle in Raspberry Pi with Docker & Remote" )
            , ( "https://www.youtube.com/watch?v=kTeUuLXzwzk", "2018. DevOpsDay Jakarta. DevOps practice in nonprofit" )
            , ( "https://www.youtube.com/watch?v=hLw0WZQajUo", "2017. PyCon Indonesia. Playful Load Testing with Locust" )
            ]
    in
    List.append
        [ h2 [] [ text "Talks" ]
        , p [] [ text "Occasionally, I speak in various tech events, these are my recent talks." ]
        ]
        (viewList data)
        |> div []


viewCompanies : Html Msg
viewCompanies =
    let
        data =
            [ ( "https://kulkul.tech/", "Kulkul Tech" )
            , ( "https://084soft.com/", "084Soft" )
            ]
    in
    List.append
        [ h2 [] [ text "Companies" ]
        , p [] [ text "I really interested in entrepreneurial activities, and in 2020 despite the pandemic, I manage to start one. Here are some companies I actively working on" ]
        ]
        (viewList data)
        |> div []


viewList : List ( String, String ) -> List (Html msg)
viewList data =
    List.indexedMap
        (\index ( url, txt ) ->
            p
                [ class <| pickBorder index
                ]
                [ linkNewTab [ class "deco-none", href url ] [ text txt ] ]
        )
        data


viewFooter =
    p [ class "footer" ] [ text "Copyright (c) mpj.io 2021" ]


linkNewTab : List (Html.Attribute msg) -> List (Html msg) -> Html msg
linkNewTab attrs children =
    a (List.append [ target "_blank" ] attrs) children


pickBorder : Int -> String
pickBorder index =
    if modBy 3 index == 0 then
        "red-border"

    else if modBy 2 index == 0 then
        "green-border"

    else
        "blue-border"



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }

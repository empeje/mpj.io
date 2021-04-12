module Main exposing (..)

import Browser
import Html exposing (Html, a, div, h1, h2, img, li, p, text, ul)
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
        , viewPublications
        , viewTalks
        , viewCompanies
        , viewInvestments
        , viewFooter
        ]


viewHeader : Html Msg
viewHeader =
    div [ class "header" ]
        [ viewNav
        , h1 [] [ text "Towards entrepreneurial and investment wisdom" ]
        , p [] [ text "by MPJ (not Michael Jordan)" ]
        , img [ class "logo", src "https://github.com/empeje.png" ] []
        , p [] [ text "I'm a software engineer and tech creator living in Indonesia. I'm a big fan of Rocket Raccoon." ]
        ]


viewNav : Html Msg
viewNav =
    div [ class "navigation" ]
        [ ul []
            [ li [] [ a [ href "https://calendly.com/a-mappuji/mentoring?month=2021-04" ] [ text "Mentor Me!" ] ]
            ]
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


viewPublications : Html Msg
viewPublications =
    let
        data =
            [ ( "https://engj.org/index.php/ej/article/view/3432", "2020. Engineering Journal. Design of an Acoustic-Based Nondestructive Test (NDT) Instrument to Predict the Modulus of Elasticity of Wood" )
            , ( "http://etd.repository.ugm.ac.id/home/detail_pencarian/111249", "2017. Undergraduate Thesis Universitas Gadjah Mada. Design and Implementation of Nondestructive Evaluation Instrument for Acoustics-based Prediction of Wood Modulus of Elasticity and a Method to Assess the Recorded Longitudinal Stress Wave" )
            , ( "https://ieeexplore.ieee.org/document/7863250", "2016. International Conference on Information Technology and Electrical Engineering Yogyakarta. Study of Raspberry Pi 2 Quad-core Cortex-A7 CPU Cluster as a Mini Supercomputer" )
            , ( "https://arxiv.org/abs/1612.08560", "2015. International Conference on Science and Technology Yogyakarta. PDM (Probes Distance Meter), Distance Measuring Instrument by Using Ultrasonic Propagation between Probes" )
            ]
    in
    List.append
        [ h2 [] [ text "Publications" ]
        , p [] [ text "I spent almost 5 years in college and it has a big influence on me. I learn how to learn solely for curiosity and it turned out resulting several research publications. Here are my past publications as I don't write any new research publications anymore." ]
        ]
        (viewList data)
        |> div []


viewTalks : Html Msg
viewTalks =
    let
        data =
            [ ( "https://www.webdirections.org/lazyload/speakers/abdurrachman-mappuji.php", "2021. Web Directions Lazy Load. How Russian Doll Caching Can Improve Server Side Rendering (Upcoming)" )
            , ( "https://youtu.be/lSguqR93rjs?t=685", "2021. Conf42 Java. Enjoy Typesafe Web Development with Eta (Upcoming)" )
            , ( "https://www.youtube.com/watch?v=YXOCGFzOtPo", "2021. KulWeekend #3 Markov Chain Bots" )
            , ( "https://www.youtube.com/watch?v=4wuN2UOVSp4", "2020. KulWeekend #2 Data Cleaning" )
            , ( "https://www.youtube.com/watch?v=n-Em6-Xt4Co", "2020. KulWeekend #1 Introduction to Python & Web Scrapping" )
            , ( "https://www.youtube.com/watch?v=HOkyc23ZKE4", "2020. KulTalks. Build and Deploy Your First Website (In Bahasa)" )
            , ( "https://www.youtube.com/watch?v=gHi4l1N62wc", "2020. SabernX. Intro to Social Coding with Git & GitHub (In Bahasa)" )
            , ( "https://www.youtube.com/watch?v=jFP_ompB0vs", "2018. MoodleMoot Philippines. Deploy Moodle in Raspberry Pi with Docker & Remote" )
            , ( "https://www.youtube.com/watch?v=kTeUuLXzwzk", "2018. DevOpsDay Jakarta. DevOps practice in nonprofit" )
            , ( "https://www.youtube.com/watch?v=hLw0WZQajUo", "2017. PyCon Indonesia Surabaya. Playful Load Testing with Locust" )
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
            , ( "https://084soft.com/", "084Soft (Closed)" )
            ]
    in
    List.append
        [ h2 [] [ text "Companies" ]
        , p [] [ text "I really interested in entrepreneurial activities, and in 2020 despite the pandemic, I manage to start one. Here are some companies I actively working on" ]
        ]
        (viewList data)
        |> div []


viewInvestments : Html Msg
viewInvestments =
    let
        data =
            [ ( "https://republic.co/abdurrachman-mappuji", "Gumroad" )
            , ( "https://wefunder.com/abdurrachmanmappuji", "Kyndoo" )
            , ( "https://wefunder.com/abdurrachmanmappuji", "Airthium (YC S17)" )
            , ( "https://wefunder.com/abdurrachmanmappuji", "InnaMed (YC W17)" )
            , ( "https://wefunder.com/abdurrachmanmappuji", "Legion M" )
            , ( "https://wefunder.com/abdurrachmanmappuji", "LPPFusion" )
            , ( "https://wefunder.com/abdurrachmanmappuji", "Vin Social" )
            ]
    in
    List.append
        [ h2 [] [ text "Investments" ]
        , p [] [ text "I invest in business from time to time, my principle on investing is value investing, and when I do, I value-add my investment through evangelism and constructive feedback. Here are some business I have invested." ]
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

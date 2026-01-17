module Pages.Writings exposing (view)

import Html exposing (Html, div, h1, h2, iframe, p, text)
import Html.Attributes exposing (attribute, class, height, src, title, width)
import Shared


view : Html msg
view =
    div []
        [ h1 [] [ text "Writings" ]
        , p [] [ text "My blogs, publications, and written works." ]
        , Shared.viewBreak
        , viewVideo "https://www.youtube.com/embed/lFZ6e4Plfb4?si=ZproA6U2rNkDchlH&amp;start=14"
        , Shared.viewBreak
        , viewBlogs
        , Shared.viewBreak
        , viewPublications
        ]


viewVideo : String -> Html msg
viewVideo youtubeLink =
    div [ class "responsive-iframe-container" ]
        [ iframe
            [ width 560
            , height 315
            , src youtubeLink
            , title ""
            , attribute "frameborder" "0"
            , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , attribute "allowfullscreen" ""
            ]
            []
        ]


viewBlogs : Html msg
viewBlogs =
    let
        data =
            [ ( "https://medium.com/@empeje/subscribe", "Regular Writing on Tech, Wisdom & Philosophy—Medium" )
            , ( "https://com6.substack.com", "COM6: The Serial Dispatch from Abdu Códigos" )
            , ( "https://www.codementor.io/@amappuji#:~:text=Community%20Posts", "Popular Blog on Codementor" )
            , ( "https://legacy.mpj.io", "Legacy Blog (2018-2020)" )
            ]
    in
    List.append
        [ h2 [] [ text "Blogs" ]
        , p [] [ text "I write blogs on various platforms, here are links to places where I write tech stuff." ]
        ]
        (Shared.viewList data)
        |> div []


viewPublications : Html msg
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
        (Shared.viewList data)
        |> div []

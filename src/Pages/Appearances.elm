module Pages.Appearances exposing (view)

import Html exposing (Html, div, h1, h2, iframe, p, text)
import Html.Attributes exposing (attribute, class, height, src, title, width)
import Shared


view : Html msg
view =
    div []
        [ h1 [] [ text "Appearances" ]
        , p [] [ text "My public speaking engagements and media coverages." ]
        , Shared.viewBreak
        , viewVideo "https://www.youtube.com/embed/ZpMzprmWBfo"
        , Shared.viewBreak
        , viewTalks
        , Shared.viewBreak
        , viewCoverages
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


viewTalks : Html msg
viewTalks =
    List.append
        [ h2 [] [ text "Talks" ]
        , p [] [ text "Occasionally, I speak in various tech events, these are my recent talks." ]
        ]
        (Shared.viewList Shared.talksData)
        |> div []


viewCoverages : Html msg
viewCoverages =
    let
        data =
            [ ( "https://imaginecup.microsoft.com/en-us/competition/17382", "2016 Hello Cloud Challenge Winner. 2016. Microsoft Imagine Cup" )
            , ( "https://rizafahmi.com/2018/07/12/rangkuman-acara-devc-jakarta-build-day-2018/", "Rangkuman Acara Developer Circles Jakarta Build Day. 2018. Facebook Developer Indonesia" )
            , ( "https://medium.com/compfest/software-engineering-academy-camp-1-berbagai-cara-untuk-membangun-software-481055ad70d1", "Software Engineering Academy Camp 1: Berbagai Cara untuk Membangun Software. 2021. COMPFEST 13 - Universitas Indonesia" )
            , ( "https://twitter.com/StacksOrg/status/1647374496620314629?s=20", "Stacks Chapter. 2023. Stacks Open Internet Foundation" )
            ]
    in
    List.append
        [ h2 [] [ text "Coverages" ]
        , p [] [ text "Below is notable coverage of mine." ]
        ]
        (Shared.viewList data)
        |> div []

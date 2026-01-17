module Pages.Home exposing (view)

import Html exposing (Html, div, h1, h2, img, node, p, text)
import Html.Attributes exposing (alt, attribute, class, src)
import Shared


view : Html msg
view =
    div []
        [ viewHeader
        , viewNewsletter
        , viewAsSeenAt
        ]


viewHeader : Html msg
viewHeader =
    div []
        [ div [ class "hero-section" ]
            [ div [ class "hero-content" ]
                [ div [ class "hero-image" ]
                    [ img
                        [ src "hero-1.jpg"
                        , attribute "alt" "Abdu Códigos Mappuji"
                        ]
                        []
                    ]
                , div [ class "hero-text" ]
                    [ h1 [ class "hero-name" ] [ text "Abdu \"Códigos\" Mappuji" ]
                    , p [ class "hero-credentials" ]
                        [ text "World-class Author and CTO-Mentor" ]
                    , p [ class "hero-description" ]
                        [ text "Abdu is an engineer at Bol, trained in UGM, Indonesia's premier institution. He mentors the next generation of software engineers—many now work at Amazon, Netflix, NVIDIA, and other big tech. He also an active legal scholar with his studies in Universitas Muhammadiyah." ]
                    ]
                ]
            ]
        ]


viewNewsletter : Html msg
viewNewsletter =
    div [ class "newsletter-section" ]
        [ div [ class "newsletter-content" ]
            [ div [ class "newsletter-text" ]
                [ p [ class "newsletter-headline" ]
                    [ text "Want to excel in your career? Subscribe to Abdu's Newsletter" ]
                , p [ class "newsletter-description" ]
                    [ text "Sign up to join more than 2,000 subscribers who receive Abdu's essays delivered to their inbox every week." ]
                ]
            , node "kit-form" [] []
            ]
        ]


viewAsSeenAt : Html msg
viewAsSeenAt =
    div [ class "as-seen-at-hero" ]
        [ div [ class "as-seen-at-content" ]
            [ h2 [ class "as-seen-at-title" ] [ text "As seen at" ]
            , div [ class "as-seen-at-logos" ]
                [ Shared.linkNewTab [ Shared.hrefWithUtmSource "https://blog.venturemagazine.net/", class "logo-link" ]
                    [ img [ src "coverages/venturemagazine.png", alt "Venture Magazine", class "coverage-logo" ] [] ]
                , Shared.linkNewTab [ Shared.hrefWithUtmSource "https://ieeexplore.ieee.org/author/37086081499", class "logo-link" ]
                    [ img [ src "coverages/ieee.png", alt "IEEE", class "coverage-logo" ] [] ]
                , Shared.linkNewTab [ Shared.hrefWithUtmSource "https://leanpub.com/u/empeje", class "logo-link" ]
                    [ img [ src "coverages/leanpub.svg", alt "Leanpub", class "coverage-logo" ] [] ]
                , Shared.linkNewTab [ Shared.hrefWithUtmSource "https://medium.com/coinmonks", class "logo-link" ]
                    [ img [ src "coverages/coinmonks.png", alt "Coinmonks", class "coverage-logo" ] [] ]
                , Shared.linkNewTab [ Shared.hrefWithUtmSource "https://medium.com/compfest/software-engineering-academy-camp-1-berbagai-cara-untuk-membangun-software-481055ad70d1", class "logo-link" ]
                    [ img [ src "coverages/compfest.png", alt "Compfest", class "coverage-logo" ] [] ]
                ]
            ]
        ]

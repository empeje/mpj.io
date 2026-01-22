module Shared exposing (..)

import Html exposing (Html, a, button, div, h3, hr, i, img, li, p, text, ul)
import Html.Attributes exposing (alt, attribute, class, href, src, target, title)
import Time


type Msg
    = NoOp


viewBreak : Html msg
viewBreak =
    hr [] []


viewNav : String -> Html msg
viewNav currentPage =
    div [ class "navigation" ]
        [ ul []
            [ li [] [ a [ href "/", title "Home page" ] [ text "Home" ] ]
            , li []
                [ div [ class "dropdown" ]
                    [ button [ class "dropbtn" ] [ text "Product" ]
                    , div [ class "dropdown-content" ]
                        [ linkNewTab [ hrefWithUtmSource "https://sistemas.mpj.io", title "Visit Sistemas" ] [ text "Sistemas" ]
                        ]
                    ]
                ]
            , li []
                [ div [ class "dropdown" ]
                    [ button [ class "dropbtn" ] [ text "Erudition" ]
                    , div [ class "dropdown-content" ]
                        [ linkNewTab [ hrefWithUtmSource "https://blog.mpj.io", title "Read blog posts" ] [ text "Blog" ]
                        , a [ href "/writings", title "View blogs and publications" ] [ text "Writings" ]
                        , linkNewTab [ hrefWithUtmSource "https://com6.substack.com", title "Subscribe to Substack newsletter" ] [ text "Substack" ]
                        , linkNewTab [ hrefWithUtmSource "https://www.youtube.com/channel/UCHxI3i2iobjq226ze-N-QBA", title "Watch YouTube videos" ] [ text "YouTube" ]
                        , linkNewTab [ hrefWithUtmSource "https://leanpub.com/u/empeje", title "Read books on Leanpub" ] [ text "Leanpub" ]
                        ]
                    ]
                ]
            , li []
                [ div [ class "dropdown" ]
                    [ button [ class "dropbtn" ] [ text "Jurisprudence" ]
                    , div [ class "dropdown-content" ]
                        [ linkNewTab [ hrefWithUtmSource "https://lawtech.mpj.io", title "Visit LawTech website" ] [ text "LawTech" ]
                        ]
                    ]
                ]
            , li []
                [ div [ class "dropdown" ]
                    [ button [ class "dropbtn" ] [ text "More" ]
                    , div [ class "dropdown-content" ]
                        [ a [ href "/hire-me", title "Hire as fractional CTO or mentor" ] [ text "Hire Me" ]
                        , a [ href "/entrepreneurship", title "View entrepreneurial ventures" ] [ text "Entrepreneurship" ]
                        , linkNewTab [ hrefWithUtmSource "https://scholar.google.com/citations?user=aRReMSEAAAAJ&hl=en", title "View publications on Google Scholar" ] [ text "Google Scholar" ]
                        , linkNewTab [ hrefWithUtmSource "https://legacy.mpj.io", title "Visit legacy blog" ] [ text "Legacy Blog" ]
                        , a [ href "/offers", title "View special offers and referrals" ] [ text "Offers" ]
                        ]
                    ]
                ]
            ]
        ]


viewFooter : Time.Posix -> Html msg
viewFooter time =
    let
        zone =
            Time.utc

        currentYear =
            Time.toYear zone time
    in
    div [ class "footer" ]
        [ div [ class "footer-content" ]
            [ div [ class "footer-copyright" ]
                [ p [] [ text ("© 2017-" ++ String.fromInt currentYear ++ " Abdu \"Códigos\" Mappuji · All Rights Reserved") ]
                , p [ class "footer-easter-egg" ]
                    [ text "Because you read until the end, here's an easter egg for you: I'm a big fan of Marvel's Rocket Raccoon. If you've already navigated through my other pages, you might have noticed it already." ]
                ]
            , div [ class "footer-quick-links" ]
                [ Html.h3 [] [ text "Quick Links" ]
                , a [ href "/appearances", class "footer-link", title "View public speaking engagements and talks" ] [ text "Appearances" ]
                , a [ href "/entrepreneurship", class "footer-link", title "View entrepreneurial ventures and investments" ] [ text "Investments" ]
                , a [ href "/offers", class "footer-link", title "Special offers and referral links" ] [ text "Offers" ]
                ]
            , div [ class "footer-quick-links" ]
                [ Html.h3 [] [ text "Connect" ]
                , linkNewTab [ hrefWithUtmSource "https://discord.com/invite/TEAJHURh2e", class "footer-link", title "Join private Discord community" ] [ text "Private Community" ]
                , linkNewTab [ hrefWithUtmSource "https://lu.ma/u/mpj", class "footer-link", title "Find upcoming events on Lu.ma" ] [ text "Lu.ma" ]
                , linkNewTab [ hrefWithUtmSource "https://www.meetup.com/members/279285007/", class "footer-link", title "Connect on Meetup" ] [ text "Meetup" ]
                ]
            ]
        ]


linkNewTab : List (Html.Attribute msg) -> List (Html msg) -> Html msg
linkNewTab attrs children =
    a (List.append [ target "_blank", attribute "rel" "noopener noreferrer" ] attrs) children


imgBadge : List (Html.Attribute msg) -> List (Html msg) -> Html msg
imgBadge attrs children =
    img (List.append [ class "img-badge" ] attrs) children


hrefWithUtmSource : String -> Html.Attribute msg
hrefWithUtmSource url =
    let
        separator =
            if String.contains "?" url then
                "&"

            else
                "?"

        urlWithUtm =
            url ++ separator ++ "utm_source=mpj.io"
    in
    href urlWithUtm


pickBorder : Int -> String
pickBorder index =
    if modBy 3 index == 0 then
        "red-border"

    else if modBy 2 index == 0 then
        "green-border"

    else
        "blue-border"


viewList : List ( String, String ) -> List (Html msg)
viewList data =
    List.indexedMap
        (\index ( url, txt ) ->
            p
                [ class <| pickBorder index
                ]
                [ linkNewTab [ class "deco-none", hrefWithUtmSource url ] [ text txt ] ]
        )
        data


talksData : List ( String, String )
talksData =
    [ ( "https://www.youtube.com/live/w3AH3jIrXXo?feature=shared&t=1579", "2025. Building and monetizing MCP servers on Apify" )
    , ( "https://youtu.be/-2fBQXFpN7Q?feature=shared&t=3264", "2024. Gadjah Mada Blockchain Club: Road to Devcon Empowering the Next Generation of Web3 Innovators" )
    , ( "https://www.youtube.com/watch?v=n0U_7fK-YBY", "2023. Encode Club. Hologram AI Pitch" )
    , ( "https://yavaconf.com/en/", "Wednesday, September 28, 2022. Ya!vaConf - Complete Web3 & Ethereun with Scala" )
    , ( "https://www.meetup.com/scalawaw/events/288163720/", "Tuesday, September 6, 2022. ScalaWAW #24 - back to school - Web3 & Ethereun with Scala" )
    , ( "https://youtu.be/SXljxRDzfGY", "2022. Remote Skills Academy. DAO Masterclass (In Bahasa)" )
    , ( "https://youtu.be/hPCP_42jcH0", "2022. Republik Rupiah. Perspektif DEVELOPER Web3: Membangun Saat BEAR Market | Indonesia (In Bahasa)" )
    , ( "https://www.youtube.com/watch?v=HE-81zhcCig&t=3027s", "2022. Podcast Indonesia Belajar. Seputar Smart Contract bersama Abdu Códigos (In Bahasa)" )
    , ( "https://us02web.zoom.us/rec/play/UR3gIJNnMzttJ_THqBtL8OWMJ4lCYOzGM_lM4BGggHnWrpcAWod0bwauaeXUxdVksBDAYtHkKlUsJWkN.te-e7mqNlXT-SN9c?continueMode=true&_x_zm_rtaid=ucgVi34HRgqf1s1nCtieiQ.1650350871201.02dbdc11ba23e3e6d3d29524f3b907e5&_x_zm_rhtaid=503", "2021. Remote Skills Academy Bali. Low-code Masterclass with Retool (In Bahasa) - Passcode: %UuDV0iG" )
    , ( "https://pycon.id/speaker/", "2021. Pycon Indonesia. Blockchain 101: Deploy your first smart contract with Python" )
    , ( "https://player.vimeo.com/video/561110523?dnt=1&app_id=122963&controls=1&hd=1&autohide=1#t=7924", "2021. Web Directions Lazy Load. How Russian Doll Caching Can Improve Server Side Rendering" )
    , ( "https://www.youtube.com/watch?v=xGcQK0VCngI", "2021. Conf42 Java. Enjoy Typesafe Web Development with Eta" )
    , ( "https://www.youtube.com/watch?v=YXOCGFzOtPo", "2021. KulWeekend #3 Markov Chain Bots" )
    , ( "https://www.youtube.com/watch?v=4wuN2UOVSp4", "2020. KulWeekend #2 Data Cleaning" )
    , ( "https://www.youtube.com/watch?v=n-Em6-Xt4Co", "2020. KulWeekend #1 Introduction to Python & Web Scrapping" )
    , ( "https://www.youtube.com/watch?v=HOkyc23ZKE4", "2020. KulTalks. Build and Deploy Your First Website (In Bahasa)" )
    , ( "https://www.youtube.com/watch?v=gHi4l1N62wc", "2020. SabernX. Intro to Social Coding with Git & GitHub (In Bahasa)" )
    , ( "https://elmjapan.guupa.com/speakers/Abdurrachman_Mappuji", "2020. ElmJapan. How Teaching Convince Me to Use Elm in Production (Cancelled due to COVID-19)" )
    , ( "https://www.youtube.com/watch?v=jFP_ompB0vs", "2018. MoodleMoot Philippines. Deploy Moodle in Raspberry Pi with Docker & Remote" )
    , ( "https://www.youtube.com/watch?v=kTeUuLXzwzk", "2018. DevOpsDay Jakarta. DevOps practice in nonprofit" )
    , ( "https://www.youtube.com/watch?v=hLw0WZQajUo", "2017. PyCon Indonesia Surabaya. Playful Load Testing with Locust" )
    ]


viewRecentEvent : Html msg
viewRecentEvent =
    List.append
        [ Html.h1 [] [ text "Recent Event" ]
        , p [] [ text "Please refer below for an interesting event that I recently participated / involved with" ]
        ]
        (viewList (List.take 2 talksData))
        |> div []

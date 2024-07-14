module Main exposing (..)

import Browser
import Html exposing (Html, a, blockquote, br, button, div, h1, h2, h3, hr, i, iframe, img, li, node, p, text, ul)
import Html.Attributes exposing (alt, attribute, class, dir, height, href, id, lang, src, style, target, title, width)
import Task
import Time



---- MODEL ----


type alias Model =
    { time : Time.Posix }


init : ( Model, Cmd Msg )
init =
    ( Model (Time.millisToPosix 0), getTime )


linktree : String
linktree =
    "https://linktr.ee/yokulguy?ref=mpj.io"



---- UPDATE ----


type Msg
    = NoOp
    | OnTime Time.Posix


getTime : Cmd Msg
getTime =
    Task.perform OnTime Time.now


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnTime time ->
            ( { model | time = time }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "container content" ]
        [ viewHeader
        , viewVideo
        , viewRecentEvent
        , viewBreak
        , viewHireMe
        , viewBreak
        , viewBlogs
        , viewPublications
        , viewTalks
        , viewCoverages
        , viewCompanies
        , viewInvestments
        , viewFooter model
        ]


viewBreak : Html Msg
viewBreak =
    hr [] []


viewHeader : Html Msg
viewHeader =
    div [ class "header" ]
        [ viewNav
        , h1 [] [ text "Towards entrepreneurial and investment wisdom" ]
        , p [] [ text "by MPJ" ]
        , div [ style "display" "flex", style "align-items" "center" ]
            [ div [ style "flex" "1", style "margin-right" "16px" ]
                [ img
                    [ class "logo"
                    , src "https://github.com/empeje.png"
                    , style "border-radius" "50%"
                    , style "width" "100%" -- Set the width to 100% to make the image responsive
                    ]
                    []
                ]
            , div [ style "flex" "3" ]
                [ p [] [ text "I'm a 💻 software engineer, 🏗️ builder, and mentor to highly-motivated engineers." ]
                , p []
                    [ a [ href "https://www.goodreads.com/en/book/show/248069.Child_of_All_Nations", target "_blank" ] [ text "Child of all nations 🌎" ]
                    , text " & Born and raised in Indonesia 🇮🇩."
                    ]
                , p [] [ text "Fun fact: I'm a big fan of 🚀🦝 Rocket Raccoon." ]
                ]
            ]
        ]


viewRecentEvent : Html Msg
viewRecentEvent =
    List.append
        [ h1 [] [ text "Recent Event" ]
        , p [] [ text "Please refer below for an interesting event that I recently participated / involved with" ]
        ]
        (viewList (List.take 2 talksData))
        |> div []


viewHireMe : Html Msg
viewHireMe =
    div [ class "hire-me" ]
        [ h1 [ id "hire-me" ] [ text "Hire Me!" ]
        , h2 [ id "hire-me-cto" ] [ text "Fractional/Consulting CTO" ]
        , p [] [ text "Beside my full-time role, I also currently a fractional Chief Technology Officer (fCTO) to highly-selected companies! I work with companies that need technical guidance for tech products who wants to go 🌏 world-class, from complex web applications to data science, AI, and blockchain even before it was cool. I work with companies top management to translate the business strategy into a solid tech roadmap." ]
        , p [] [ text "Here are some curated list of companies/startups I have advised as their fractional CTO." ]
        , ul []
            [ li [] [ text "A confidential mining company" ]
            , li [] [ text "A confidential NFT marketplace" ]
            , li [] [ linkNewTab [ href "https://tryhologram.art" ] [ text "Hologram AI" ] ]
            ]
        , p [] [ text "If you're a business owner who wants to bring your company's tech to the next level, consult with me at a (dot) mappuji (at) gmail (dot) com." ]
        , viewBreak
        , h2 [ id "hire-me-mentor" ] [ text "Exclusive Mentoring" ]
        , p [] [ text "I run a highly-selective mentoring for high-potential engineers to be 🌏 world-class in their crafts. Mentee includes Fortune 500 companies engineers from Amazon, Redhat, SAP, etc." ]
        , linkNewTab [ href linktree ]
            [ imgBadge
                [ src "1-mentoring-package-private.png"
                , alt "1 Hour Private Mentoring with world-class mentor (5 Star in Codementor). Special price only $70."
                ]
                []
            ]
        , linkNewTab [ href linktree ]
            [ imgBadge
                [ src "2-mentoring-package-exclusive.png"
                , alt "8 x 1 Hour Exclusive Mentoring with world-class mentor (5 Star in Codementor). All for only $500."
                ]
                []
            ]
        , linkNewTab [ href linktree ]
            [ imgBadge
                [ src "3-mentoring-package-complete.png"
                , alt "8 x 2 Hour Complete, Exclusive and & Personalized Mentoring with world-class mentor (5 Star in Codementor). Get your study plan now! All exclusive benefits for only $2000."
                ]
                []
            ]
        , p [] [ i [] [ text "*) Payment doesn't guarantee acceptance. Refund applicable for rejected mentees." ] ]
        , viewBreak
        , viewMyMentee
        ]


viewMyMentee : Html Msg
viewMyMentee =
    div []
        [ h2 [ id "mentee-works" ] [ text "Mentee works" ]
        , p [] [ text "Here are some examples of the work that has been done by my mentees." ]
        , h3 [] [ text "CI/CD Gitlab pipeline by Aurélien Lair" ]
        , blockquote
            [ class "twitter-tweet"
            ]
            [ p
                [ lang "en"
                , dir "ltr"
                ]
                [ text "📣📣📣 Find out my last proof of concept of a CI/CD Gitlab pipeline runnable both locally or on"
                , a
                    [ href "https://twitter.com/hashtag/gitlab?src=hash&ref_src=twsrc%5Etfw"
                    ]
                    [ text "#gitlab" ]
                , text "with custom gitlab-runner"
                , br []
                    []
                , text "A special thanks to MPJ"
                , a
                    [ href "https://twitter.com/YoKulGuy?ref_src=twsrc%5Etfw"
                    ]
                    [ text "@YoKulGuy" ]
                , text "for his help on this. You are my Miyagi sensei bro 🇯🇵 🙇 🙏"
                , br []
                    []
                , br []
                    []
                , text "↪"
                , a
                    [ href "https://t.co/WLrzXDarWp"
                    ]
                    [ text "https://t.co/WLrzXDarWp" ]
                ]
            , text "— Aurélien Lair (@aurelien_lair)"
            , a
                [ href "https://twitter.com/aurelien_lair/status/1650490509645758471?ref_src=twsrc%5Etfw"
                ]
                [ text "April 24, 2023" ]
            ]
        , node "script"
            [ attribute "async" ""
            , src "https://platform.twitter.com/widgets.js"
            , attribute "charset" "utf-8"
            ]
            []
        ]


viewNav : Html Msg
viewNav =
    div [ class "navigation" ]
        [ ul []
            [ li [] [ a [ href "#hire-me-mentor" ] [ text "Mentoring" ] ]
            , li [] [ a [ href "#hire-me-cto" ] [ text "fCTO" ] ]
            , li [] [ linkNewTab [ href "https://blog.mpj.io" ] [ text "Blog" ] ]
            , li []
                [ div [ class "dropdown" ]
                    [ button [ class "dropbtn" ] [ text "More" ]
                    , div [ class "dropdown-content" ]
                        [ linkNewTab [ href "https://linktr.ee/yokulguy" ] [ text "Mentor me!" ]
                        , linkNewTab [ href "https://www.youtube.com/channel/UCHxI3i2iobjq226ze-N-QBA" ] [ text "YouTube" ]
                        , linkNewTab [ href "https://leanpub.com/u/empeje" ] [ text "Books" ]
                        , linkNewTab [ href "https://scholar.google.com/citations?user=aRReMSEAAAAJ&hl=en" ] [ text "Google Scholar" ]
                        , linkNewTab [ href "https://buidling.substack.com" ] [ text "Teman Stacks Podcast" ]
                        , linkNewTab [ href "https://www.meetup.com/members/279285007/" ] [ text "Meetup.com" ]
                        , linkNewTab [ href "https://lu.ma/u/mpj" ] [ text "Lu.ma" ]
                        , linkNewTab [ href "https://legacy.mpj.io" ] [ text "Legacy Blog" ]
                        ]
                    ]
                ]
            ]
        ]


viewVideo : Html Msg
viewVideo =
    div [ class "responsive-iframe-container" ]
        [ iframe
            [ width 560
            , height 315
            , src "https://www.youtube.com/embed/ZpMzprmWBfo"
            , title ""
            , attribute "frameborder" "0"
            , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , attribute "allowfullscreen" ""
            ]
            []
        ]


viewBlogs : Html Msg
viewBlogs =
    let
        data =
            [ ( "https://medium.com/@empeje/subscribe", "Regular Writing on Tech, Wisdom & Philosophy—Medium" )
            , ( "https://twitter.com/@YoKulGuy", "Not-so Regular tweet on X" )
            , ( "https://www.codementor.io/@amappuji#:~:text=Community%20Posts", "Popular Blog on Codementor" )
            , ( "https://legacy.mpj.io", "Legacy Blog (2018-2020)" )
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


viewCoverages : Html Msg
viewCoverages =
    let
        data =
            [ ( "https://issuu.com/lpktaftugm/docs/sonar", "Belajar Kepemimpinan. 2017. Engineering Journal. Sonar - Majalah Ilmia Populer LPKTA FT UGM" )
            , ( "https://rizafahmi.com/2018/07/12/rangkuman-acara-devc-jakarta-build-day-2018/", "Rangkuman Acara Developer Circles Jakarta Build Day. 2018. Facebook Developer Indonesia" )
            , ( "https://medium.com/compfest/software-engineering-academy-camp-1-berbagai-cara-untuk-membangun-software-481055ad70d1", "Software Engineering Academy Camp 1: Berbagai Cara untuk Membangun Software. 2021. COMPFEST 13 - Universitas Indonesia" )
            , ( "https://twitter.com/StacksOrg/status/1647374496620314629?s=20", "Stacks Chapter. 2023. Stacks Open Internet Foundation" )
            ]
    in
    List.append
        [ h2 [] [ text "Coverages" ]
        , p [] [ text "Below is notable coverage of mine." ]
        ]
        (viewList data)
        |> div []


talksData : List ( String, String )
talksData =
    [ ( "https://yavaconf.com/en/", "Wednesday, September 28, 2022. Ya!vaConf - Complete Web3 & Ethereun with Scala" )
    , ( "https://www.meetup.com/scalawaw/events/288163720/", "Tuesday, September 6, 2022. ScalaWAW #24 - back to school - Web3 & Ethereun with Scala" )
    , ( "https://youtu.be/SXljxRDzfGY", "2022. Remote Skills Academy. DAO Masterclass (In Bahasa)" )
    , ( "https://youtu.be/hPCP_42jcH0", "2022. Republik Rupiah. Perspektif DEVELOPER Web3: Membangun Saat BEAR Market | Indonesia (In Bahasa)" )
    , ( "https://www.youtube.com/watch?v=HE-81zhcCig&t=3027s", "2022. Podcast Indonesia Belajar. Seputar Smart Contract bersama Abdurrachman Mappuji (In Bahasa)" )
    , ( "https://us02web.zoom.us/rec/play/UR3gIJNnMzttJ_THqBtL8OWMJ4lCYOzGM_lM4BGggHnWrpcAWod0bwauaeXUxdVksBDAYtHkKlUsJWkN.te-e7mqNlXT-SN9c?continueMode=true&_x_zm_rtaid=ucgVi34HRgqf1s1nCtieiQ.1650350871201.02dbdc11ba23e3e6d3d29524f3b907e5&_x_zm_rhtaid=503", "2021. Remote Skills Academy Bali. Low-code Masterclass with Retool (In Bahasa) - Passcode: %UuDV0iG" )
    , ( "https://pycon.id/speaker/", "2021. Pycon Indonesia. Blockchain 101: Deploy your first smart contract with Python" )
    , ( "https://player.vimeo.com/video/561110523?dnt=1&app_id=122963&controls=1&hd=1&autohide=1#t=7924", "2021. Web Directions Lazy Load. How Russian Doll Caching Can Improve Server Side Rendering" )
    , ( "https://www.youtube.com/watch?v=xGcQK0VCngI", "2021. Conf42 Java. Enjoy Typesafe Web Development with Eta" )
    , ( "https://www.youtube.com/watch?v=YXOCGFzOtPo", "2021. KulWeekend #3 Markov Chain Bots" )
    , ( "https://www.youtube.com/watch?v=4wuN2UOVSp4", "2020. KulWeekend #2 Data Cleaning" )
    , ( "https://www.youtube.com/watch?v=n-Em6-Xt4Co", "2020. KulWeekend #1 Introduction to Python & Web Scrapping" )
    , ( "https://www.youtube.com/watch?v=HOkyc23ZKE4", "2020. KulTalks. Build and Deploy Your First Website (In Bahasa)" )
    , ( "https://www.youtube.com/watch?v=gHi4l1N62wc", "2020. SabernX. Intro to Social Coding with Git & GitHub (In Bahasa)" )
    , ( "https://www.youtube.com/watch?v=jFP_ompB0vs", "2018. MoodleMoot Philippines. Deploy Moodle in Raspberry Pi with Docker & Remote" )
    , ( "https://www.youtube.com/watch?v=kTeUuLXzwzk", "2018. DevOpsDay Jakarta. DevOps practice in nonprofit" )
    , ( "https://www.youtube.com/watch?v=hLw0WZQajUo", "2017. PyCon Indonesia Surabaya. Playful Load Testing with Locust" )
    ]


viewTalks : Html Msg
viewTalks =
    List.append
        [ h2 [ id "talks" ] [ text "Talks" ]
        , p [] [ text "Occasionally, I speak in various tech events, these are my recent talks." ]
        ]
        (viewList talksData)
        |> div []


viewCompanies : Html Msg
viewCompanies =
    let
        data =
            [ ( "https://www.glassdoor.com/Reviews/Kulkul-Reviews-E3830299.htm", "Kulkul Tech (I'm having 100% CEO Approval in Glassdoor!) - Stepped Down" )
            , ( "https://mpj.io/#404", "084Soft (Closed)" )
            ]
    in
    List.append
        [ h2 [] [ text "Companies" ]
        , p [] [ text "I really interested in entrepreneurial activities, and in 2020 despite the pandemic, I manage to start one. Here are some companies I actively / was active on" ]
        ]
        (viewList data)
        |> div []


viewInvestments : Html Msg
viewInvestments =
    let
        data =
            [ ( "https://republic.co/abdurrachman-mappuji", "Gumroad" )
            , ( "https://kyndoo.com/", "Kyndoo (Acquired by CIPIO.ai)" )
            , ( "https://www.airthium.com/", "Airthium (YC S17)" )
            , ( "https://www.innamed.com/", "InnaMed (YC W17)" )
            , ( "https://legionm.com/", "Legion M" )
            , ( "https://lppfusion.com/", "LPPFusion" )
            , ( "https://vinsocial.co/", "Vin Social" )
            , ( "https://en.aktpictures.com/", "Akt Pictures - When I Was a Human" )
            , ( "https://arc.dev/", "Arc (Previously Codementor)" )
            , ( "https://earnestcapital.com/", "Earnest Capital" )
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


viewFooter : Model -> Html msg
viewFooter model =
    let
        zone =
            Time.utc

        -- or use a specific time zone
    in
    p [ class "footer" ] [ text ("Copyright (c) mpj.io " ++ String.fromInt (Time.toYear zone model.time)) ]


linkNewTab : List (Html.Attribute msg) -> List (Html msg) -> Html msg
linkNewTab attrs children =
    a (List.append [ target "_blank" ] attrs) children


imgBadge : List (Html.Attribute msg) -> List (Html msg) -> Html msg
imgBadge attrs children =
    img (List.append [ width 300 ] attrs) children


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

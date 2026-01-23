port module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, div, node)
import Html.Attributes exposing (attribute, class, name)
import Pages.Appearances
import Pages.Entrepreneurship
import Pages.HireMe
import Pages.Home
import Pages.Offers
import Pages.Writings
import Shared
import Task
import Time
import Url
import Url.Parser as Parser exposing (Parser, map, oneOf, s, top)



---- PORTS ----


port updateStructuredData : String -> Cmd msg



---- MODEL ----


type Route
    = Home
    | Appearances
    | HireMe
    | Writings
    | Entrepreneurship
    | Offers
    | NotFound


type alias Model =
    { time : Time.Posix
    , route : Route
    , key : Nav.Key
    , offersModel : Pages.Offers.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        route =
            parseUrl url
    in
    ( { time = Time.millisToPosix 0
      , route = route
      , key = key
      , offersModel = Pages.Offers.init
      }
    , Cmd.batch [ getTime, updateStructuredData (getStructuredDataForRoute route) ]
    )


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map Appearances (s "appearances")
        , map HireMe (s "hire-me")
        , map Writings (s "writings")
        , map Entrepreneurship (s "entrepreneurship")
        , map Offers (s "offers")
        ]


parseUrl : Url.Url -> Route
parseUrl url =
    Parser.parse routeParser url
        |> Maybe.withDefault NotFound



---- UPDATE ----


type Msg
    = NoOp
    | OnTime Time.Posix
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OffersMsg Pages.Offers.Msg


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

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                newRoute =
                    parseUrl url
            in
            ( { model | route = newRoute }, updateStructuredData (getStructuredDataForRoute newRoute) )

        OffersMsg offersMsg ->
            ( { model | offersModel = Pages.Offers.update offersMsg model.offersModel }, Cmd.none )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Abdu \"Códigos\" Mappuji - The CTO-mentor, Engineer, Legal Scholar"
    , body =
        [ node "meta" [ name "description", attribute "content" (getMetaDescription model.route) ] []
        , div [ class "container content" ]
            [ Shared.viewNav (routeToString model.route)
            , viewPage model
            ]
        , Shared.viewFooter model.time
        ]
    }


getMetaDescription : Route -> String
getMetaDescription route =
    case route of
        Home ->
            "Abdu Códigos Mappuji is a world-class CTO-mentor, engineer at Bol, and legal scholar. Mentoring engineers at Amazon, Netflix, NVIDIA, and other big tech companies. Subscribe to his newsletter with 2,000+ subscribers."

        Appearances ->
            "Public speaking engagements, tech talks, and media coverage by Abdu Códigos Mappuji. Featured in IEEE, Leanpub, Venture Magazine, Coinmonks, and Compfest. Watch talks on Web3, blockchain, DevOps, and software engineering."

        HireMe ->
            "Hire Abdu Códigos Mappuji as your fractional CTO or join exclusive mentoring programs. Work with a 5-star Codementor who has mentored engineers from Amazon, Netflix, and NVIDIA. Get technical guidance for world-class products."

        Writings ->
            "Blogs, publications, and written works by Abdu Códigos Mappuji. Read tech articles on Medium, Substack, and Codementor. Academic publications on IEEE, engineering research, and software development best practices."

        Entrepreneurship ->
            "Entrepreneurial ventures and investments by Abdu Códigos Mappuji. Founded Kulkul Tech with 100% CEO approval on Glassdoor. Angel investor in YC companies including AptDeco, Airthium, and InnaMed."

        Offers ->
            "Special offers and referral links curated by Abdu Códigos Mappuji. Get exclusive benefits for Perplexity AI, Wise, and other premium services. Sign up through these links for special discounts and bonuses."

        NotFound ->
            "Page not found on Abdu Códigos Mappuji's website. Return to the home page to explore mentoring services, tech talks, blog posts, and entrepreneurial ventures."


getStructuredDataForRoute : Route -> String
getStructuredDataForRoute route =
    case route of
        HireMe ->
            """{"@context":"https://schema.org","@type":"Product","name":"Exclusive Mentoring by Abdu Mappuji","description":"Highly-selective mentoring for high-potential engineers to be world-class in their crafts. Mentee includes Fortune 500 companies engineers from Amazon, Redhat, SAP, etc.","brand":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"offers":{"@type":"AggregateOffer","priceCurrency":"USD","lowPrice":"70","highPrice":"2000","offerCount":"3"},"aggregateRating":{"@type":"AggregateRating","ratingValue":"5.0","bestRating":"5","worstRating":"1","ratingCount":"2"},"review":[{"@type":"Review","reviewRating":{"@type":"Rating","ratingValue":"5","bestRating":"5"},"author":{"@type":"Person","name":"Wihlarko Prasdegdho (Edo)","jobTitle":"Senior Engineer at Tridorian","url":"https://www.linkedin.com/in/wihlarko-prasdegdho"},"reviewBody":"I recently have the privilege of being mentored in a 1-on-1 session with MPJ, and i'am incredibly grateful for the experience. He shared insightful tips and tricks on how to win the hearts of HR and hiring managers during interviews, and also gave me valuable feedback on my CV. From that session, i realized there were many aspects of my CV and self-presentation that needed improvement, with his guidance i was able to refine my CV and develop a better approach to interviews. As a result, i started receiving multiple interview invitations including opportunities offering relocation to Europe and i'am now excited to share that I have landed a fulltime remote role at a multinational company based in Singapore. Thank you so much, MPJ, for your support and mentorship, it truly made a real difference in my journey!","datePublished":"2024-01-15"},{"@type":"Review","reviewRating":{"@type":"Rating","ratingValue":"5","bestRating":"5"},"author":{"@type":"Person","name":"Aurélien Lair","url":"https://twitter.com/aurelien_lair"},"reviewBody":"Find out my last proof of concept of a CI/CD Gitlab pipeline runnable both locally or on gitlab with custom gitlab-runner. A special thanks to MPJ @YoKulGuy for his help on this. You are my Miyagi sensei bro 🇯🇵 🙇 🙏","datePublished":"2023-04-24"}]}"""

        Appearances ->
            """{"@context":"https://schema.org","@type":"ItemList","name":"Tech Talks and Speaking Engagements by Abdu Mappuji","description":"Public speaking engagements, tech talks, and conference presentations by Abdu Mappuji covering topics like Web3, blockchain, DevOps, Python, Elm, and software engineering.","itemListElement":[{"@type":"ListItem","position":1,"item":{"@type":"Event","name":"Building and monetizing MCP servers on Apify","description":"Talk about building and monetizing MCP servers on Apify platform","startDate":"2025-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/live/w3AH3jIrXXo?feature=shared&t=1579"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Apify"}}},{"@type":"ListItem","position":2,"item":{"@type":"Event","name":"Road to Devcon: Empowering the Next Generation of Web3 Innovators","description":"Talk at Gadjah Mada Blockchain Club about empowering Web3 innovators","startDate":"2024-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://youtu.be/-2fBQXFpN7Q?feature=shared&t=3264"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Gadjah Mada Blockchain Club"}}},{"@type":"ListItem","position":3,"item":{"@type":"Event","name":"Hologram AI Pitch at Encode Club","description":"Pitch presentation for Hologram AI project","startDate":"2023-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=n0U_7fK-YBY"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Encode Club"}}},{"@type":"ListItem","position":4,"item":{"@type":"Event","name":"Complete Web3 & Ethereum with Scala","description":"Ya!vaConf talk about Web3 and Ethereum development with Scala","startDate":"2022-09-28","eventAttendanceMode":"https://schema.org/OfflineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"Place","name":"Ya!vaConf","url":"https://yavaconf.com/en/"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Ya!vaConf"}}},{"@type":"ListItem","position":5,"item":{"@type":"Event","name":"Web3 & Ethereum with Scala","description":"ScalaWAW meetup talk about Web3 and Ethereum with Scala","startDate":"2022-09-06","eventAttendanceMode":"https://schema.org/OfflineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"Place","name":"ScalaWAW","url":"https://www.meetup.com/scalawaw/events/288163720/"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"ScalaWAW"}}},{"@type":"ListItem","position":6,"item":{"@type":"Event","name":"DAO Masterclass","description":"Remote Skills Academy masterclass on Decentralized Autonomous Organizations","startDate":"2022-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://youtu.be/SXljxRDzfGY"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Remote Skills Academy"},"inLanguage":"id"}},{"@type":"ListItem","position":7,"item":{"@type":"Event","name":"Developer Perspective on Web3: Building During Bear Market","description":"Republik Rupiah talk about Web3 development perspective during bear market","startDate":"2022-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://youtu.be/hPCP_42jcH0"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Republik Rupiah"},"inLanguage":"id"}},{"@type":"ListItem","position":8,"item":{"@type":"Event","name":"Smart Contract Discussion","description":"Podcast Indonesia Belajar episode about smart contracts","startDate":"2022-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=HE-81zhcCig&t=3027s"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Podcast Indonesia Belajar"},"inLanguage":"id"}},{"@type":"ListItem","position":9,"item":{"@type":"Event","name":"Low-code Masterclass with Retool","description":"Remote Skills Academy Bali masterclass on low-code development with Retool","startDate":"2021-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://us02web.zoom.us/rec/play/UR3gIJNnMzttJ_THqBtL8OWMJ4lCYOzGM_lM4BGggHnWrpcAWod0bwauaeXUxdVksBDAYtHkKlUsJWkN.te-e7mqNlXT-SN9c"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Remote Skills Academy Bali"},"inLanguage":"id"}},{"@type":"ListItem","position":10,"item":{"@type":"Event","name":"Blockchain 101: Deploy your first smart contract with Python","description":"PyCon Indonesia talk about blockchain and smart contract deployment with Python","startDate":"2021-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://pycon.id/speaker/"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"PyCon Indonesia"}}},{"@type":"ListItem","position":11,"item":{"@type":"Event","name":"How Russian Doll Caching Can Improve Server Side Rendering","description":"Web Directions Lazy Load talk about Russian Doll caching technique for SSR","startDate":"2021-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://player.vimeo.com/video/561110523"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Web Directions"}}},{"@type":"ListItem","position":12,"item":{"@type":"Event","name":"Enjoy Typesafe Web Development with Eta","description":"Conf42 Java talk about typesafe web development using Eta language","startDate":"2021-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=xGcQK0VCngI"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Conf42"},"about":{"@type":"Thing","name":"Java"}}},{"@type":"ListItem","position":13,"item":{"@type":"Event","name":"KulWeekend #3: Markov Chain Bots","description":"KulWeekend session about Markov Chain bots","startDate":"2021-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=YXOCGFzOtPo"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Kulkul Tech"}}},{"@type":"ListItem","position":14,"item":{"@type":"Event","name":"KulWeekend #2: Data Cleaning","description":"KulWeekend session about data cleaning techniques","startDate":"2020-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=4wuN2UOVSp4"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Kulkul Tech"}}},{"@type":"ListItem","position":15,"item":{"@type":"Event","name":"KulWeekend #1: Introduction to Python & Web Scraping","description":"KulWeekend session introducing Python and web scraping","startDate":"2020-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=n-Em6-Xt4Co"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Kulkul Tech"}}},{"@type":"ListItem","position":16,"item":{"@type":"Event","name":"Build and Deploy Your First Website","description":"KulTalks session on building and deploying websites","startDate":"2020-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=HOkyc23ZKE4"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"Kulkul Tech"},"inLanguage":"id"}},{"@type":"ListItem","position":17,"item":{"@type":"Event","name":"Intro to Social Coding with Git & GitHub","description":"SabernX talk introducing Git and GitHub for social coding","startDate":"2020-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=gHi4l1N62wc"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"SabernX"},"inLanguage":"id"}},{"@type":"ListItem","position":18,"item":{"@type":"Event","name":"How Teaching Convinced Me to Use Elm in Production","description":"ElmJapan talk about using Elm in production environments (cancelled due to COVID-19)","startDate":"2020-01-01","eventAttendanceMode":"https://schema.org/OfflineEventAttendanceMode","eventStatus":"https://schema.org/EventCancelled","location":{"@type":"Place","name":"ElmJapan","url":"https://elmjapan.guupa.com/speakers/Abdurrachman_Mappuji"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"ElmJapan"}}},{"@type":"ListItem","position":19,"item":{"@type":"Event","name":"Deploy Moodle in Raspberry Pi with Docker","description":"MoodleMoot Philippines talk about deploying Moodle on Raspberry Pi using Docker","startDate":"2018-01-01","eventAttendanceMode":"https://schema.org/OnlineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"VirtualLocation","url":"https://www.youtube.com/watch?v=jFP_ompB0vs"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"MoodleMoot Philippines"}}},{"@type":"ListItem","position":20,"item":{"@type":"Event","name":"DevOps Practice in Nonprofit","description":"DevOpsDay Jakarta talk about implementing DevOps practices in nonprofit organizations","startDate":"2018-01-01","eventAttendanceMode":"https://schema.org/OfflineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"Place","name":"DevOpsDay Jakarta","url":"https://www.youtube.com/watch?v=kTeUuLXzwzk"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"DevOpsDay Jakarta"}}},{"@type":"ListItem","position":21,"item":{"@type":"Event","name":"Playful Load Testing with Locust","description":"PyCon Indonesia Surabaya talk about load testing using Locust framework","startDate":"2017-01-01","eventAttendanceMode":"https://schema.org/OfflineEventAttendanceMode","eventStatus":"https://schema.org/EventScheduled","location":{"@type":"Place","name":"PyCon Indonesia Surabaya","url":"https://www.youtube.com/watch?v=hLw0WZQajUo"},"performer":{"@type":"Person","name":"Abdu Mappuji","url":"https://mpj.io"},"organizer":{"@type":"Organization","name":"PyCon Indonesia"}}}]}"""

        _ ->
            ""


viewPage : Model -> Html Msg
viewPage model =
    case model.route of
        Home ->
            Pages.Home.view

        Appearances ->
            Pages.Appearances.view

        HireMe ->
            Pages.HireMe.view

        Writings ->
            Pages.Writings.view

        Entrepreneurship ->
            Pages.Entrepreneurship.view

        Offers ->
            Html.map OffersMsg (Pages.Offers.view model.offersModel)

        NotFound ->
            div [ class "container content" ]
                [ Html.h1 [] [ Html.text "404 - Page Not Found" ]
                , Html.p [] [ Html.text "The page you're looking for doesn't exist." ]
                , Html.a [ Html.Attributes.href "/" ] [ Html.text "Go back home" ]
                ]


routeToString : Route -> String
routeToString route =
    case route of
        Home ->
            "home"

        Appearances ->
            "appearances"

        HireMe ->
            "hire-me"

        Writings ->
            "writings"

        Entrepreneurship ->
            "entrepreneurship"

        Offers ->
            "offers"

        NotFound ->
            "not-found"



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }

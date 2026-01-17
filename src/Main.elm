module Main exposing (..)

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
    ( { time = Time.millisToPosix 0
      , route = parseUrl url
      , key = key
      , offersModel = Pages.Offers.init
      }
    , getTime
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
            ( { model | route = parseUrl url }, Cmd.none )

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

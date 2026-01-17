module Pages.Offers exposing (Model, Msg(..), init, update, view)

import Html exposing (Html, div, h1, h2, input, p, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (attribute, class, id, placeholder, type_, value)
import Html.Events exposing (onInput)
import Shared


type alias Model =
    { referralsFilter : String
    }


type Msg
    = UpdateReferralsFilter String


init : Model
init =
    { referralsFilter = "" }


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateReferralsFilter filter ->
            { model | referralsFilter = filter }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Offers & Referrals" ]
        , viewReferrals model
        ]


type alias ReferralLink =
    { productName : String
    , referralUrl : String
    , benefit : String
    }


referralData : List ReferralLink
referralData =
    [ { productName = "Perplexity"
      , referralUrl = "https://www.perplexity.ai/referrals/2QC16RJD"
      , benefit = "One month Pro for free"
      }
    , { productName = "Wise"
      , referralUrl = "https://wise.com/invite/dic/abdurrachmanm"
      , benefit = "Get zero fees on a transfer up to IDR 9,000,000."
      }
    ]


viewReferrals : Model -> Html Msg
viewReferrals model =
    let
        filteredLinks =
            referralData
                |> List.filter
                    (\link ->
                        String.contains (String.toLower model.referralsFilter) (String.toLower link.productName)
                    )
    in
    div [ id "referrals" ]
        [ h2 [] [ text "Referrals" ]
        , p [] [ text "Here are some great services I use and recommend. Sign up through these links to get special benefits!" ]
        , viewReferralsSearchFilter model.referralsFilter
        , viewReferralsTable filteredLinks
        , p [ class "disclaimer" ] [ text "* Benefits may vary and are subject to the terms and conditions of each service provider." ]
        ]


viewReferralsSearchFilter : String -> Html Msg
viewReferralsSearchFilter searchFilter =
    div [ class "search-container" ]
        [ input
            [ type_ "text"
            , placeholder "Search products..."
            , value searchFilter
            , onInput UpdateReferralsFilter
            , class "search-input"
            ]
            []
        ]


viewReferralsTable : List ReferralLink -> Html Msg
viewReferralsTable links =
    table [ class "referral-table" ]
        [ thead []
            [ tr []
                [ th [] [ text "Product Name" ]
                , th [] [ text "Referral Link" ]
                , th [] [ text "Benefit" ]
                ]
            ]
        , tbody []
            (List.indexedMap viewReferralTableRow links)
        ]


viewReferralTableRow : Int -> ReferralLink -> Html Msg
viewReferralTableRow index link =
    tr [ class <| Shared.pickBorder index ]
        [ td [ class "product-name", attribute "data-label" "Product Name" ] [ text link.productName ]
        , td [ class "referral-link", attribute "data-label" "Referral Link" ]
            [ Shared.linkNewTab [ Shared.hrefWithUtmSource link.referralUrl, class "referral-button" ] [ text "Sign Up" ]
            ]
        , td [ class "benefit", attribute "data-label" "Benefit" ] [ text link.benefit ]
        ]

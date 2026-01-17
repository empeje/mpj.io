module Pages.Entrepreneurship exposing (view)

import Html exposing (Html, div, h1, h2, p, text)
import Html.Attributes exposing (class)
import Shared


view : Html msg
view =
    div []
        [ h1 [] [ text "Entrepreneurship" ]
        , p [] [ text "My entrepreneurial ventures and investments." ]
        , Shared.viewBreak
        , viewCompanies
        , Shared.viewBreak
        , viewInvestments
        ]


viewCompanies : Html msg
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
        (Shared.viewList data)
        |> div []


viewInvestments : Html msg
viewInvestments =
    let
        data =
            [ ( "https://www.ycombinator.com/companies/aptdeco", "AptDeco (YC W14)" )
            , ( "https://www.ycombinator.com/companies/airthium", "Airthium (YC S17)" )
            , ( "https://www.ycombinator.com/companies/innamed", "InnaMed (YC W17)" )
            , ( "https://earnestcapital.com/", "Earnest Capital" )
            , ( "https://en.aktpictures.com/", "Akt Pictures - When I Was a Human" )
            , ( "https://republic.co/abdurrachman-mappuji", "Gumroad" )
            , ( "https://legionm.com/", "Legion M" )
            , ( "https://lppfusion.com/", "LPPFusion" )
            , ( "https://vinsocial.co/", "Vin Social" )
            , ( "https://arc.dev/", "Arc (Previously Codementor, Exited to Toptal)" )
            , ( "https://kyndoo.com/", "Kyndoo (Exited to CIPIO.ai)" )
            ]
    in
    List.append
        [ h2 [] [ text "Investments" ]
        , p [] [ text "I invest in business from time to time, my principle on investing is value investing, and when I do, I value-add my investment through evangelism and constructive feedback. Here are some business I have invested." ]
        ]
        (Shared.viewList data)
        |> div []

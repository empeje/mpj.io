module Pages.HireMe exposing (view)

import Html exposing (Html, a, blockquote, br, button, div, h1, h2, h4, i, iframe, img, node, p, text)
import Html.Attributes exposing (alt, attribute, class, dir, height, href, id, lang, src, target, title, width)
import Shared


linktree : String
linktree =
    "https://linktr.ee/yokulguy"


view : Html msg
view =
    div []
        [ h1 [] [ text "Hire Me" ]
        , Shared.viewBreak
        , viewHireMe
        , Shared.viewBreak
        , Shared.viewRecentEvent
        ]


viewHireMe : Html msg
viewHireMe =
    div [ class "hire-me" ]
        (List.append
            [ h2 [ id "hire-me-cto" ] [ text "Fractional/Consulting CTO" ]
            , p [] [ text "Beside my full-time role, I serve as a fractional Chief Technology Officer (fCTO) to highly-selected companies from time to time! I work with companies that need technical guidance for tech products who wants to go 🌏 world-class, from complex web applications to data science, AI, and blockchain even before it was cool. I work with companies top management to translate the business strategy into a solid tech roadmap." ]
            , p [] [ text "Here are some curated list of companies/startups I have advised as their fractional CTO." ]
            ]
            (List.append
                (Shared.viewList
                    [ ( "#", "A confidential mining company" )
                    , ( "#", "A confidential NFT marketplace" )
                    , ( "https://hologram.kul.to", "Hologram AI" )
                    ]
                )
                [ p [] [ text "If you're a business owner who wants to bring your company's tech to the next level, consult with me at zing (dot) passers0k (at) icloud.com." ]
                , Shared.viewBreak
                , h2 [ id "hire-me-mentor" ] [ text "Exclusive Mentoring" ]
                , p [] [ text "I run a highly-selective mentoring for high-potential engineers to be 🌏 world-class in their crafts. Mentee includes Fortune 500 companies engineers from Amazon, Redhat, SAP, etc." ]
                , Shared.linkNewTab [ href linktree ]
                    [ Shared.imgBadge
                        [ src "1-mentoring-package-private.png"
                        , alt "1 Hour Private Mentoring with world-class mentor (5 Star in Codementor). Special price only $70."
                        ]
                        []
                    ]
                , Shared.linkNewTab [ href linktree ]
                    [ Shared.imgBadge
                        [ src "2-mentoring-package-exclusive.png"
                        , alt "8 x 1 Hour Exclusive Mentoring with world-class mentor (5 Star in Codementor). All for only $500."
                        ]
                        []
                    ]
                , Shared.linkNewTab [ href linktree ]
                    [ Shared.imgBadge
                        [ src "3-mentoring-package-complete.png"
                        , alt "8 x 2 Hour Complete, Exclusive and & Personalized Mentoring with world-class mentor (5 Star in Codementor). Get your study plan now! All exclusive benefits for only $2000."
                        ]
                        []
                    ]
                , p [] [ i [] [ text "*) Payment doesn't guarantee acceptance. Refund applicable for rejected mentees." ] ]
                , Shared.viewBreak
                , viewMyMentees
                ]
            )
        )


viewEdo : Html msg
viewEdo =
    div []
        [ p []
            [ Shared.linkNewTab [ Shared.hrefWithUtmSource "https://www.linkedin.com/in/wihlarko-prasdegdho" ] [ text "Wihlarko Prasdegdho" ]
            , text " - Senior Engineer at Tridorian "
            , Shared.linkNewTab [ Shared.hrefWithUtmSource "https://www.linkedin.com/in/wihlarko-prasdegdho" ] [ text "↗" ]
            ]
        , blockquote [ class "edo-testimonial" ]
            [ text "\"I recently have the privilege of being mentored in a 1-on-1 session with MPJ, and i'am incredibly grateful for the experience. He shared insightful tips and tricks on how to win the hearts of HR and hiring managers during interviews, and also gave me valuable feedback on my CV. From that session, i realized there were many aspects of my CV and self-presentation that needed improvement, with his guidance i was able to refine my CV and develop a better approach to interviews. As a result, i started receiving multiple interview invitations including opportunities offering relocation to Europe and i'am now excited to share that I have landed a fulltime remote role at a multinational company based in Singapore. Thank you so much, MPJ, for your support and mentorship, it truly made a real difference in my journey!\""
            ]
        ]


viewAurelien : Html msg
viewAurelien =
    div []
        [ blockquote
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


viewMenteeCard : String -> Html msg -> Html msg
viewMenteeCard title content =
    div [ class "mentee-card" ]
        [ h4 [ class "mentee-card-title" ] [ text title ]
        , div [ class "mentee-card-content" ] [ content ]
        ]


viewMyMentees : Html msg
viewMyMentees =
    div []
        [ h2 [ id "mentee-works" ] [ text "Mentee works" ]
        , p [] [ text "Here are some examples of the work that has been done by my mentees." ]
        , div [ class "mentee-showcase" ]
            [ viewMenteeCard "CI/CD Gitlab Pipeline - Aurélien Lair" viewAurelien
            , viewMenteeCard "Tech Interview Success - Edo" viewEdo
            ]
        ]

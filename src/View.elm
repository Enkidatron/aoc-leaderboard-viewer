module View exposing (view)

import Browser
import Date
import Example
import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import RemoteData exposing (RemoteData(..))
import Types exposing (..)
import View.Plot exposing (plot)


view : Model -> Browser.Document Msg
view model =
    { title = "AoC Leaderboard Viewer"
    , body =
        [ H.div [ HA.class "container" ]
            [ H.div []
                [ heading
                , form model
                ]
            , H.div []
                [ exampleWarning model
                , plot model
                ]
            ]
        ]
    }


exampleWarningText : String
exampleWarningText =
    "This is just an example plot, paste your own URL and cookie."


exampleWarning : Model -> Html Msg
exampleWarning model =
    -- TODO bootstrap warning box
    if Example.shouldShow model then
        H.div
            [ HA.class "alert alert-info"
            , HA.attribute "role" "alert"
            ]
            [ H.text exampleWarningText ]

    else
        H.text ""


plotButton : Plot -> Plot -> Html Msg
plotButton plot currentlySelectedPlot =
    let
        isActive =
            plot == currentlySelectedPlot
    in
    H.label
        [ HA.classList
            [ ( "btn", True )
            , ( "btn-secondary", True )
            , ( "active", isActive )
            ]
        ]
        [ H.input
            [ HA.type_ "radio"
            , HA.name "plot-type"
            , HA.attribute "autocomplete" "off"
            , HA.checked isActive
            , HE.onClick (ShowPlot plot)
            ]
            []
        , H.text (plotLabel plot)
        ]


plotLabel : Plot -> String
plotLabel plot =
    case plot of
        AllInOne ->
            "all members in one plot"

        OneForEachMember ->
            "one plot for each member"


heading : Html Msg
heading =
    H.h1
        [ HA.class "my-4" ]
        [ H.text "AoC private leaderboard viewer" ]


form : Model -> Html Msg
form model =
    H.div []
        [ dataInput model
        , radioButtons model
        ]


dataInput : Model -> Html Msg
dataInput model =
    H.div
        [ HA.class "form-group row" ]
        [ H.label [ HA.class "col-lg-3 col-form-label" ]
            [ H.text "Leaderboard JSON:"
            ]
        , H.div [ HA.class "col-lg-9" ]
            [ H.input
                [ HA.placeholder <| "JSON, eg. from: " ++ Example.url
                , HA.value model.data
                , HA.class "form-control"
                , HE.onInput SetData
                ]
                []
            ]
        ]


radioButtons : Model -> Html Msg
radioButtons model =
    H.div [ HA.class "form-group row" ]
        [ H.label
            [ HA.class "col-lg-3 col-form-label" ]
            [ H.text "Show plot:" ]
        , H.div [ HA.class "col-lg-9" ]
            [ H.div
                [ HA.class "btn-group"
                , HA.attribute "data-toggle" "buttons"
                , HA.attribute "role" "group"
                , HA.attribute "aria-label" "Show plot"
                ]
                [ plotButton OneForEachMember model.plot
                , plotButton AllInOne model.plot
                ]
            ]
        ]

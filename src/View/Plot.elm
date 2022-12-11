module View.Plot exposing (fromString, plot, toString)

import Example
import Html as H exposing (Html)
import Http exposing (Error(..))
import Json
import Json.Decode
import RemoteData exposing (RemoteData(..))
import Types exposing (..)
import View.Plot.Type.AllInOne as View
import View.Plot.Type.OneForEachMember as View


toString : Plot -> String
toString plot_ =
    case plot_ of
        OneForEachMember ->
            "OneForEachMember"

        AllInOne ->
            "AllInOne"


fromString : String -> Result String Plot
fromString string =
    case string of
        "OneForEachMember" ->
            Ok OneForEachMember

        "AllInOne" ->
            Ok AllInOne

        _ ->
            Err <| "wrong plot type snapshot: " ++ string


plot : Model -> Html Msg
plot model =
    H.div []
        (if Example.shouldShow model then
            plotView model Example.data

         else
            case Json.Decode.decodeString Json.dataDecoder model.data of
                Err err ->
                    [ viewFailure err ]

                Ok data ->
                    plotView model data
        )


plotView : Model -> Data -> List (Html Msg)
plotView model data =
    let
        filteredData =
            data
                |> List.filter (\member -> member.stars > 0)
    in
    case model.plot of
        AllInOne ->
            View.allInOne model filteredData

        OneForEachMember ->
            View.oneForEachMember model filteredData


viewFailure : Json.Decode.Error -> Html Msg
viewFailure err =
    H.text <| "Error: " ++ Json.Decode.errorToString err

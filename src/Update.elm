port module Update exposing (init, subscriptions, update)

import Http
import Json exposing (dataDecoder)
import RemoteData exposing (RemoteData(..))
import Task
import Time
import Types exposing (..)
import View.Plot as Plot


init : Flags -> ( Model, Cmd Msg )
init { currentTime, snapshot } =
    ( snapshot
        |> Maybe.andThen
            (\{ data, plot } ->
                plot
                    |> Plot.fromString
                    |> Result.toMaybe
                    |> Maybe.map
                        (\plot_ ->
                            { data = data
                            , zone = Time.utc
                            , hover = Nothing
                            , plot = plot_
                            }
                        )
            )
        |> Maybe.withDefault
            { data = ""
            , zone = Time.utc
            , hover = Nothing
            , plot = OneForEachMember
            }
    , Task.perform CurrentZone Time.here
    )


port saveSnapshot : Snapshot -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetData data ->
            let
                newModel =
                    { model | data = data }
            in
            ( newModel
            , saveSnapshot
                { data = data
                , plot = Plot.toString model.plot
                }
            )

        CurrentZone zone ->
            ( { model | zone = zone }
            , Cmd.none
            )

        Hover hover ->
            ( { model | hover = hover }
            , Cmd.none
            )

        ShowPlot plot ->
            let
                newModel =
                    { model | plot = plot }
            in
            ( newModel
            , saveSnapshot
                { data = model.data
                , plot = Plot.toString plot
                }
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

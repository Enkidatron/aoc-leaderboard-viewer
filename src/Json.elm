module Json exposing (dataDecoder)

import Date
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Extra as JDE
import Time exposing (Posix)
import Types exposing (..)


dataDecoder : Decoder Data
dataDecoder =
    JD.field "members" (JD.keyValuePairs memberDecoder)
        |> JD.map (List.map Tuple.second)
        |> JD.map (\data -> data |> List.filter (\member -> member.stars > 0))


memberDecoder : Decoder Member
memberDecoder =
    JD.map6 Member
        (JD.field "name" (JD.maybe JD.string))
        (JD.field "id" (JD.map String.fromInt JD.int))
        (JD.field "local_score" JD.int)
        (JD.field "global_score" JD.int)
        (JD.field "stars" JD.int)
        (JD.field "completion_day_level" completionTimesDecoder)


posixDecoder : Decoder Posix
posixDecoder =
    JD.int
        |> JD.map (\int -> Time.millisToPosix <| int * 1000)


completionTimesDecoder : Decoder (List ( Day, Star, Posix ))
completionTimesDecoder =
    JD.keyValuePairs (JD.keyValuePairs (JD.field "get_star_ts" posixDecoder))
        |> JD.map
            (\days ->
                days
                    |> List.concatMap
                        (\( day, stars ) ->
                            List.filterMap
                                (\( star, posix ) ->
                                    Maybe.map2 (\d s -> ( d, s, posix ))
                                        (String.toInt day)
                                        (String.toInt star)
                                )
                                stars
                        )
            )

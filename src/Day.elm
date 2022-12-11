module Day exposing (..)

import List.Extra


startOfAoC : Float
startOfAoC =
    -- 2022/12/01, 05:00 GMT
    -- in milliseconds
    1669867200000


endOfAoC : Float
endOfAoC =
    startOfAoC + day * 26


day : Float
day =
    -- in milliseconds
    86400000


comfortableRange : Float -> ( Float, Float )
comfortableRange dataMax =
    ( startOfAoC
    , findComfortableRange (dataMax + day) startOfAoC
    )


findComfortableRange : Float -> Float -> Float
findComfortableRange dataMax current =
    let
        newTime =
            current + day
    in
    if newTime < dataMax then
        findComfortableRange dataMax newTime

    else
        current


findTicks : Float -> Float -> Float -> List Float
findTicks min max delta =
    List.Extra.iterate
        (\val ->
            let
                newVal =
                    val + delta
            in
            if newVal < max then
                Just newVal

            else
                Nothing
        )
        min
        ++ [ max ]

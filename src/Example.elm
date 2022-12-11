module Example exposing (data, shouldShow, url)

import Json exposing (..)
import Json.Decode as JD
import RemoteData exposing (RemoteData(..))
import Types exposing (..)


data : Data
data =
    case decode json of
        Ok data_ ->
            data_

        Err _ ->
            []


json : String
json =
    """{"members":{"201076":{"stars":8,"global_score":0,"local_score":11,"id":"201076","last_star_ts":"2017-12-07T01:26:24-0500","name":"schod","completion_day_level":{"4":{"1":{"get_star_ts":"2017-12-05T14:58:54-0500"},"2":{"get_star_ts":"2017-12-05T15:58:15-0500"}},"1":{"2":{"get_star_ts":"2017-12-05T09:29:03-0500"},"1":{"get_star_ts":"2017-12-01T02:26:43-0500"}},"5":{"1":{"get_star_ts":"2017-12-06T10:50:05-0500"},"2":{"get_star_ts":"2017-12-07T01:26:24-0500"}},"2":{"1":{"get_star_ts":"2017-12-05T09:53:14-0500"},"2":{"get_star_ts":"2017-12-05T10:17:24-0500"}}}},"201735":{"name":"Jaroslav Bazala","completion_day_level":{"4":{"1":{"get_star_ts":"2017-12-04T04:26:53-0500"},"2":{"get_star_ts":"2017-12-04T04:29:41-0500"}},"3":{"1":{"get_star_ts":"2017-12-03T11:13:04-0500"},"2":{"get_star_ts":"2017-12-03T13:48:26-0500"}},"6":{"2":{"get_star_ts":"2017-12-06T04:33:33-0500"},"1":{"get_star_ts":"2017-12-06T04:31:16-0500"}},"2":{"1":{"get_star_ts":"2017-12-02T12:53:19-0500"},"2":{"get_star_ts":"2017-12-02T13:35:20-0500"}},"5":{"2":{"get_star_ts":"2017-12-05T13:17:13-0500"},"1":{"get_star_ts":"2017-12-05T12:44:58-0500"}},"1":{"1":{"get_star_ts":"2017-12-01T15:07:25-0500"},"2":{"get_star_ts":"2017-12-01T15:25:55-0500"}}},"id":"201735","last_star_ts":"2017-12-06T04:33:33-0500","local_score":31,"global_score":0,"stars":12},"1114":{"local_score":60,"global_score":0,"stars":14,"name":"Martin Janiczek","completion_day_level":{"1":{"2":{"get_star_ts":"2017-12-01T00:30:53-0500"},"1":{"get_star_ts":"2017-12-01T00:17:23-0500"}},"2":{"2":{"get_star_ts":"2017-12-02T00:26:01-0500"},"1":{"get_star_ts":"2017-12-02T00:10:38-0500"}},"5":{"2":{"get_star_ts":"2017-12-05T00:20:50-0500"},"1":{"get_star_ts":"2017-12-05T00:18:25-0500"}},"6":{"1":{"get_star_ts":"2017-12-06T00:43:30-0500"},"2":{"get_star_ts":"2017-12-06T00:51:49-0500"}},"3":{"2":{"get_star_ts":"2017-12-03T01:33:07-0500"},"1":{"get_star_ts":"2017-12-03T00:50:52-0500"}},"7":{"1":{"get_star_ts":"2017-12-07T00:31:35-0500"},"2":{"get_star_ts":"2017-12-07T01:12:00-0500"}},"4":{"2":{"get_star_ts":"2017-12-04T00:43:56-0500"},"1":{"get_star_ts":"2017-12-04T00:38:41-0500"}}},"id":"1114","last_star_ts":"2017-12-07T01:12:00-0500"},"247429":{"name":"porubsky","completion_day_level":{"6":{"1":{"get_star_ts":"2017-12-06T00:13:09-0500"},"2":{"get_star_ts":"2017-12-06T00:18:04-0500"}},"3":{"1":{"get_star_ts":"2017-12-04T05:58:16-0500"},"2":{"get_star_ts":"2017-12-04T05:58:37-0500"}},"7":{"2":{"get_star_ts":"2017-12-07T01:26:42-0500"},"1":{"get_star_ts":"2017-12-07T00:39:51-0500"}},"4":{"2":{"get_star_ts":"2017-12-04T05:54:28-0500"},"1":{"get_star_ts":"2017-12-04T05:51:38-0500"}},"1":{"1":{"get_star_ts":"2017-12-04T04:22:15-0500"},"2":{"get_star_ts":"2017-12-04T05:56:03-0500"}},"2":{"1":{"get_star_ts":"2017-12-04T04:36:47-0500"},"2":{"get_star_ts":"2017-12-04T04:48:28-0500"}},"5":{"2":{"get_star_ts":"2017-12-05T00:18:38-0500"},"1":{"get_star_ts":"2017-12-05T00:15:57-0500"}}},"id":"247429","last_star_ts":"2017-12-07T01:26:42-0500","local_score":41,"stars":14,"global_score":0},"201025":{"name":"Martin Stříž","completion_day_level":{"2":{"1":{"get_star_ts":"2017-12-02T11:11:56-0500"},"2":{"get_star_ts":"2017-12-02T12:15:29-0500"}},"5":{"2":{"get_star_ts":"2017-12-05T01:50:50-0500"},"1":{"get_star_ts":"2017-12-05T01:45:35-0500"}},"1":{"1":{"get_star_ts":"2017-12-01T02:44:40-0500"},"2":{"get_star_ts":"2017-12-01T02:51:31-0500"}},"4":{"1":{"get_star_ts":"2017-12-04T00:29:11-0500"},"2":{"get_star_ts":"2017-12-04T00:36:09-0500"}},"3":{"2":{"get_star_ts":"2017-12-03T10:50:54-0500"},"1":{"get_star_ts":"2017-12-03T10:04:18-0500"}},"6":{"2":{"get_star_ts":"2017-12-06T00:20:48-0500"},"1":{"get_star_ts":"2017-12-06T00:15:21-0500"}},"7":{"1":{"get_star_ts":"2017-12-07T00:21:05-0500"},"2":{"get_star_ts":"2017-12-07T00:51:44-0500"}}},"id":"201025","last_star_ts":"2017-12-07T00:51:44-0500","local_score":57,"global_score":0,"stars":14}},"owner_id":"201025","event":"2017"}"""


decode : String -> Result JD.Error Data
decode json_ =
    JD.decodeString dataDecoder json_


shouldShow : Model -> Bool
shouldShow model =
    model.data == ""


url : String
url =
    "https://adventofcode.com/2017/leaderboard/private/view/201025.json"

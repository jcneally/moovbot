# Description:
#   Get a random list of loot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot loot the room
#
# Author:
#   jcneally

module.exports = (robot) ->
  robot.respond /loot the room/i, (msg) ->
    robot.http("http://donjon.bin.sh/d20/random/rpc.cgi?type=Purse&n=1")
      .get() (err, res, body) ->
        response = JSON.parse(body)
          if response.success == "true"
            msg.send response[0]

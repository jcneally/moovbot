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
    robot.http("http://donjon.bin.sh/d20/random/#purse")
      .get() (err, res, body) ->
        matches = body.match /<div id="out".*<li>(.*?)</li>/i

        if matches and matches[1]
          msg.send matches[1]

  robot.respond /designer excuse(?: me)?/i, (msg) ->
    msg.send msg.random(DESIGNER_EXCUSES)

url = require('url')
querystring = require('querystring')

module.exports = (robot) ->

  robot.router.post "/stagingdeploy", (req, res) ->
    #room   = req.params.room
    data   = req.body
    sha    = data.sha

    user = "17214_1083165@chat.hipchat.com"
    #user.room = query.room if query.room

    try
       robot.send user, "INCOMING MESSAGE: " + sha

       res.end "message sent"
    catch error
      console.log "message-listner error: #{error}."

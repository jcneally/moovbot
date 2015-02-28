url = require('url')
fs = require('fs')
querystring = require('querystring')

module.exports = (robot) ->

  robot.router.post "/stagingdeploy", (req, res) ->
    #room   = req.params.room
    data      = req.body
    sha       = data.sha
    commitmsg = data.commitmsg
    name      = data.proj_name
    mode      = data.proj_mode

    user = "17214_1083165@chat.hipchat.com"
    room = "17214_forever21@conf.hipchat.com"
    #user.room = query.room if query.room

    try
       robot.messageRoom room, "Deployment finished for " + name + " on " + mode + " :\n" + commitmsg + "\n"  + sha

       res.end "message sent"
    catch error
      console.log "message-listner error: #{error}."

   robot.router.get "/set_rooms", (req, res) ->
     response = ->
       fs.readFileSync "../set_rooms.html", 'utf8'
     res.end response()

url = require('url')
fs = require('fs')
querystring = require('querystring')

rooms_to_message = {}

save_rooms = (robot) ->
    robot.brain.data.rooms_to_message = rooms_to_message

module.exports = (robot) ->

  robot.brain.on 'loaded', ->
        rooms_to_message = robot.brain.data.rooms_to_message or {}

  robot.router.post "/stagingdeploy", (req, res) ->
    #room   = req.params.room
    data      = req.body
    sha       = data.sha
    commitmsg = data.commitmsg
    name      = data.proj_name
    mode      = data.proj_mode
    room_name = rooms_to_message[name]

    room = "17214_" + room_name + "@conf.hipchat.com"

    console.log("trying to message: " + room)
    console.log("rooms: " + rooms_to_message)


    unless room_name?
      res.end

    try
       robot.messageRoom room, "Deployment finished for " + name + " on " + mode + " :\n" + commitmsg + "\n"  + sha

       res.end "message sent"
    catch error
      console.log "message-listner error: #{error}."

  robot.router.get "/set_rooms", (req, res) ->
    res.sendfile("set_rooms.html")

  robot.router.post "/set_rooms", (req, res) ->
    data = req.body
    proj_name = data.proj_name
    room_name = data.room_name
    rooms_to_message[proj_name] = room_name
    save_rooms(robot)
    res.end
    #res.sendfile("set_rooms.html")

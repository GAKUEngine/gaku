#!/usr/bin/coffee

io = require("socket.io").listen(5001)
redis = require("redis").createClient()

redis.subscribe "grading-change"

io.on "connection", (socket) ->
  console.log 'Connected to GAKU'

  redis.on "message", (channel, message) ->
    console.log(channel, message)
    socket.emit "grading-change", JSON.parse(message)

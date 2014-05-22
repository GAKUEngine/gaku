io = require("socket.io").listen(5001)
redis = require("redis").createClient()

redis.subscribe "grading-change"

io.on "connection", (socket) ->
  console.log 'Client connected'

  redis.on "message", (channel, message) ->
    console.log "Message from redis: #{message}"
    socket.emit "grading-change", JSON.parse(message)

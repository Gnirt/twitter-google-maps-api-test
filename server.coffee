http = require('http')
express = require('express')
Twit = require('twit')
socketio = require('socket.io')

T = new Twit(
	consumer_key:			''
	consumer_secret:		''
	access_token:			''
	access_token_secret:	''
)

exports.startServer = (port, path, callback) ->
    app = express()
    server = http.createServer(app)
    io = socketio(server)
    stream = T.stream 'statuses/filter', {track: 'ruby, rails, ror, france'}

    stream.on 'tweet', (tweet) ->
    	console.log tweet.text
    	io.emit 'tweet', tweet

    app.use express.static "#{__dirname}/public"

    app.get '/', (request, response) ->
        response.sendFile 'public/index.html'

    server.listen port, ->
        console.log("listening on port #{port}")
        callback()

http = require('http')
express = require('express')
Twit = require('twit')
socketio = require('socket.io')

T = new Twit(
	consumer_key:			'FnNF0SgrkkvGG7Q95Gjyyy26J'
	consumer_secret:		'5MbXEE0x8bN2FmTnS0NbQosfOZGKbdjtxZQhNjXsdTaCaj0a68'
	access_token:			'502145429-3pePgc8BLAjwNmJxQCeyOzGbo19M5Gl5DRF178NT'
	access_token_secret:	'1IjDu23U8uiUzwEfgt250pbAldS6xpXuXYUWWaSPZXTH2'
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

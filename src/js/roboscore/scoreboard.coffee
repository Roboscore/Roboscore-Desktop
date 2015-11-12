http = require 'http'
fs = require 'fs'

# This encapsulates a basic HTTP server so that we can display scores through an
# attached monitor, screen, or projector, or to a remote location via a local
# area network connection. It can respond to 5 basic paths, none of which will
# process incoming data.
class Scoreboard
  @PORT: 8080

  constructor: ->
    @server = http.createServer @handleRequest

    @start()

  start: =>
    @server.listen @constructor.PORT, @startedListening

  stop: =>
    @server.close @stoppedListening

  handleRequest: (request, response) =>
    @log "Starting request for #{request.url}"

    if /^\/?$/.test request.url
      # Redirect the root to /scoreboard
      @redirectTo response, 'scoreboard'
    else if /^\/?scoreboard\/?$/.test request.url
      # Main HTML file
      @respondWithFile(response, 'html/scoreboard.html', 'text/html')
    else if /^\/?scoreboard\.css$/.test request.url
      # Main CSS file
      @respondWithFile(response, 'css/scoreboard.css', 'text/css')
    else if /^\/?scoreboard\.js$/.test request.url
      # Main JS file
      @respondWithFile(response, 'js/scoreboard.js', 'application/javascript')
    else if /^\/?scoreboard\.json$/.test request.url
      # TODO: Dynamically generate JSON data
      @respondWithData response, '{}', 'application/json'
    else
      @respondWithError response, "Unknown path: #{request.url}", 404

  respondWithData: (response, data, contentType) ->
    response.writeHeader 200, { 'Content-Type': contentType }
    response.write data
    response.end()

  respondWithFile: (response, path, contentType) ->
    full_path = "#{__dirname}/../../#{path}"

    fs.readFile full_path, (err, data) =>
      if err
        return @respondWithError response, "Could not load #{full_path}", 404

      response.writeHeader 200, { 'Content-Type': contentType }
      response.write data
      response.end()

      @log "Served file: #{path}"

  respondWithError: (response, error, code) ->
    response.writeHeader code, { 'Content-Type': 'text/plain' }
    response.write error
    response.end()

    @log "Error: #{error}"

  redirectTo: (response, path) =>
    response.writeHeader 302,
      'Location': "http://localhost:#{@constructor.PORT}/#{path}"
    response.end()

    @log "Redirected to #{path}"

  startedListening: =>
    @log "Server listening on port #{@constructor.PORT}"

  stoppedListening: =>
    @log "Stopped listening on port #{@constructor.PORT}"

  log: (message) ->
    console.log "[%s] %s", (new Date()).toISOString(), message

module.exports = Scoreboard

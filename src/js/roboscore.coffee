BrowserWindow = require 'browser-window'
ipc = require 'ipc'
http = require 'http'
shell = require 'shell'

class Roboscore
  mainWindow: null
  timerWindow: null

  constructor: ->
    @openMainWindow()

    @addEventListeners()

    # We need a function which handles requests and send response
    handleRequest = (request, response) ->
      response.end('It Works!! Path Hit: ' + request.url)

    # Create a server
    server = http.createServer handleRequest

    # Lets start our server
    server.listen 8080, ->
      # Callback triggered when server is successfully listening. Hurray!
      console.log("Server listening on: http://localhost:%s", 8080)

  addEventListeners: =>
    ipc.on 'timer.open', @openTimerWindow

    ipc.on 'timer.start', =>
      @timerWindow?.webContents.send 'timer.start'

    ipc.on 'timer.reset', =>
      @timerWindow?.webContents.send 'timer.reset'

  openMainWindow: =>
    unless @mainWindow
      @mainWindow = new BrowserWindow
        width: 600
        height: 500
        'max-width': 800
        'min-width': 200

      @mainWindow.loadUrl "file://#{__dirname}/../html/main.html"

    @mainWindow.focus()

  openTimerWindow: =>
    unless @timerWindow
      @timerWindow = new BrowserWindow
        width: 400
        height: 100
        'max-width': 800
        'min-width': 200
        'title-bar-style': 'hidden'

      @timerWindow.loadUrl "file://#{__dirname}/../html/timer.html"

    @timerWindow.focus()

module.exports = Roboscore

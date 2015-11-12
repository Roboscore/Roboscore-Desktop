BrowserWindow = require 'browser-window'
Scoreboard = require './roboscore/scoreboard'
ipc = require 'ipc'

# This is the main entry point of the application. Messages are passed back
# and forth between the individual windows through Inter-Process Communication.
class Roboscore
  mainWindow: null
  timerWindow: null

  constructor: ->
    @openMainWindow()

    @addEventListeners()

    @scoreboard = new Scoreboard

  addEventListeners: =>
    ipc.on 'timer.open', @openTimerWindow

    ipc.on 'timer.start', =>
      @timerWindow?.webContents?.send 'timer.start'

    ipc.on 'timer.reset', =>
      @timerWindow?.webContents?.send 'timer.reset'

  openMainWindow: =>
    unless @mainWindow
      @mainWindow = new BrowserWindow
        width: 600
        height: 500
        'max-width': 800
        'min-width': 200

      @mainWindow.on 'closed', =>
        @mainWindow = undefined

      @mainWindow.loadUrl "file://#{__dirname}/../html/main.html"

    @mainWindow.focus()

  openTimerWindow: =>
    unless @timerWindow
      @timerWindow = new BrowserWindow
        width: 400
        height: 100
        'min-width': 200
        'min-height': 50
        'title-bar-style': 'hidden'

      @timerWindow.on 'closed', =>
        @timerWindow = undefined

      @timerWindow.loadUrl "file://#{__dirname}/../html/timer.html"

    @timerWindow.focus()

module.exports = Roboscore

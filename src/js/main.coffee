ipc = require 'ipc'
shell = require 'shell'
remote = require 'remote'

Scoreboard = remote.require './roboscore/scoreboard'

class MainWindow
  constructor: ->
    document.getElementById('version')
      .innerText = "v#{process.env.npm_package_version}"

    @buttons =
      displayTimer: document.getElementById('display-timer')
      startTimer: document.getElementById('start-timer')
      resetTimer: document.getElementById('reset-timer')
      scoreboard: document.getElementById('scoreboard')

    @addEventListeners()

  addEventListeners: =>
    @buttons.displayTimer.onclick = ->
      ipc.send 'timer.open'

    @buttons.startTimer.onclick = ->
      ipc.send 'timer.start'

    @buttons.resetTimer.onclick = ->
      ipc.send 'timer.reset'

    @buttons.scoreboard.onclick = ->
      console.log "Opening http://localhost:#{Scoreboard.PORT}"
      shell.openExternal "http://localhost:#{Scoreboard.PORT}"

new MainWindow

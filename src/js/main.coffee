ipc = require 'ipc'
remote = require 'remote'
shell = remote.require 'shell'

class MainWindow
  constructor: ->
    document.getElementById('version')
      .innerText = "v#{process.env.npm_package_version}"

    @buttons =
      displayTimer: document.getElementById('display-timer')
      startTimer: document.getElementById('start-timer')
      resetTimer: document.getElementById('reset-timer')

    @addEventListeners()

  addEventListeners: =>
    @buttons.displayTimer.onclick = ->
      ipc.send 'timer.open'

    @buttons.startTimer.onclick = ->
      ipc.send 'timer.start'

    @buttons.resetTimer.onclick = ->
      ipc.send 'timer.reset'

new MainWindow

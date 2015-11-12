app = require 'app'
ipc = require 'ipc'
Roboscore = require './roboscore'

ipc.on 'debug', (event, args)->
  console.log args

app.on 'ready', =>
  @roboscore = new Roboscore

app.on 'before-quit', =>
  @roboscore.scoreboard.stop()

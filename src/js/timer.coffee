ipc = require 'ipc'

class TimerWindow
  # setInterval doesn't run *exactly* on time, so we'll update multiple times
  # per second to make up for it.
  @REFRESH_INTERVAL: 100

  constructor: ->
    @body = document.querySelectorAll('body')[0]
    @clock = document.getElementById 'clock'
    @startTime = null
    @interval = null

    ipc.on 'timer.start', @startTimer
    ipc.on 'timer.stop',  @stopTimer
    ipc.on 'timer.reset', @resetTimer

  startTimer: =>
    @startTime = Date.now()
    @interval = setInterval @updateTimer, 100

  stopTimer: =>
    return unless @interval

    clearInterval @interval
    @interval = null

  resetTimer: =>
    @stopTimer()
    @clock.innerText = '2:30'
    @body.className = ''

  reachedZero: =>
    @stopTimer()
    @clock.innerText = '0:00'
    @body.className = 'flash'

  # It's much more reliable to recalculate every time so we're not compounding
  # errors. Timers should be based on the start time, not the last cycle.
  updateTimer: =>
    secondsLeft = Math.floor(150 - (Date.now() - @startTime) / 1000)

    return @reachedZero() if secondsLeft < 1

    minutes = Math.floor(secondsLeft / 60)
    seconds = (secondsLeft - minutes * 60)

    seconds = "0#{seconds}" if seconds < 10

    @clock.innerText = "#{minutes}:#{seconds}"

new TimerWindow

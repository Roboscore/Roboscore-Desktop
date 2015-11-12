class Scoreboard
  constructor: ->

  reloadScores: ->

  scrollToBottom: ->

  scrollToTop: ->

  # We're going to try to find a reasonable speed to work with any tournament
  # from 8 teams to over 100, and from a tiny projector to a movie screen.
  # Initial thought: 1 row every 2 seconds. Let's see how that goes...
  calculateScrollTime: ->
    rows = document.getElementsByTagName('tbody')[0].getElementsByTagName('tr')

    return 100 if rows.length < 1

    pixelsPerSecond = rows[0].offsetHeight / 2

    pixelsToScroll = document.body.scrollHeight - window.innerHeight

    pixelsToScroll / pixelsPerSecond

new Scoreboard

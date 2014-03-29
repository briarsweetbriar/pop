Pop.RoundManager = (params) ->
  @currentRound = null
  @game = params.game

  return

Pop.RoundManager.prototype.newRound = (params) ->
  params["game"] = @game
  @currentRound = new Pop.Round(params)
  Pop.drawRound({ game: @game })
  @currentRound.selectLowestBalloon()
  return @currentRound
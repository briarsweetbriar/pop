Game = (params) ->
  this.languages = []
  this.currentLanguage = null
  this.currentRound = null
  return

Game.prototype.startRound = (params) ->
  this.currentRound = new Round(params)
Round = (params) ->
  this.balloonCount = params.balloons || 30

  this.currentInfinitive = null
  this.currentQuiz = null
  this.pops = 0
  this.drops = 0
  this.tenses = params.tenses
  this.balloons = []

  this.setNewInfinitive()

  for i in [0...this.balloonCount]
    this.balloons.push new Balloon({ tense: getRandom(this.tenses) })

  return

Round.prototype.setNewInfinitive = ->
  this.currentInfinitive = getRandom(game.currentLanguage.verbs).infinitive

Round.prototype.handleCompletion = ->
  zap = "zap"
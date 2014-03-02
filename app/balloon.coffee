Balloon = (params) ->
  this.tense = params.tense
  this.inflation = params.inflation || getRandom([35..65])
  this.inflated = true

  return

Balloon.prototype.startQuiz = ->
  quiz = new Quiz
    tense: this.tense,
    infinitive: game.currentRound.currentInfinitive,
    balloon: this
  game.currentRound.currentQuiz = quiz

Balloon.prototype.pop = ->
  game.currentRound.pops += 1
  game.currentRound.balloons.remove this
  this.inflated = false
  game.currentRound.handleCompletion()

Balloon.prototype.drop = ->
  game.currentRound.drops += 1
  game.currentRound.balloons.remove this
  this.inflated = false
  game.currentRound.handleCompletion()

Object.defineProperty Balloon.prototype, "inflation",
  get: ->
    this._inflation
  set: (amount) ->
    if amount >= 100
      this.pop()
    else if amount <= 0
      this.drop()
    else
      return this._inflation = amount
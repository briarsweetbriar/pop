Pop.Round = (params = {}) ->
  @game = params.game
  @scoreKeeper = @setScorekeeper()
  @tenses = params.tenses
  @currentInfinitive = @setCurrentInfinitive()
  @currentQuiz = null
  @balloons = if params.balloons then @populateBalloons(params.balloons) else
    @populateBalloons(Pop.Config.defaultBalloonCount)

  return

Pop.Round.prototype.setCurrentInfinitive = ->
  @currentInfinitive = Pop.getRandomElement(@game.currentLanguage().verbs).
    infinitive

Pop.Round.prototype.setScorekeeper = ->
  new Pop.ScoreKeeper(@game.currentLanguage().tenses) if @game?

Pop.Round.prototype.populateBalloons = (amount) ->
  for [1..amount]
    new Pop.Balloon(tense: Pop.getRandomElement(@tenses), round: this)

Pop.Round.prototype.lowestBalloon = ->
  currentLowest = @balloons[0]
  for balloon in @balloons
    if balloon.inflation < currentLowest.inflation && balloon.inflation > 5
      currentLowest = balloon
  return currentLowest

Pop.Round.prototype.selectLowestBalloon = ->
  balloon = @lowestBalloon()
  balloon.startQuiz() if balloon?

Pop.Round.prototype.handleCompletion = ->
  if @balloons.length == 0
    @complete()

Pop.Round.prototype.complete = ->
  Pop.Input.clear()
  Pop.Input.hide()
  for tense in @tenses
    @game.scoreKeeper["#{tense.camelize()}Pops"] +=
      @scoreKeeper["#{tense.camelize()}Pops"]
    @game.scoreKeeper["#{tense.camelize()}Drops"] +=
      @scoreKeeper["#{tense.camelize()}Drops"]
    @game.scoreKeeper.pops += @scoreKeeper.pops
    @game.scoreKeeper.drops += @scoreKeeper.drops
  @game.scoreKeeper.rounds++

  Pop.drawRoundMenu({ game: @game })
Pop.Balloon = (params) ->
  @round = params.round
  @tense = params.tense
  @active = false
  @inflation = params.inflation || Pop.getRandomInt(35, 65)
  @inflated = true
  @xCoord = Pop.getRandomInt(0, Pop.Config.canvasWidth)
  @yCoord = @setInitialYCoord()
  @xMomentum = 0
  @yMomentum = 0
  this.color = this.determineColor()

  return

Pop.Balloon.prototype.startQuiz = ->
  @activate()
  Pop.removeHint()
  Pop.Input.show()
  quiz = new Pop.Quiz
    tense: @tense,
    infinitive: @round.currentInfinitive,
    game: @round.game,
    balloon: this
  @round.currentQuiz = quiz

Pop.Balloon.prototype.activate = ->
  for balloon in @round.balloons
    balloon.active = false
  @active = true

Pop.Balloon.prototype.determineColor = ->
  Pop.game.currentLanguage().colorForTense(@tense)

Pop.Balloon.prototype.setInitialYCoord = ->
  Pop.getRandomInt(@yCoordRange()[0], @yCoordRange()[0])

Pop.Balloon.prototype.yCoordRange = ->
  ideal = (Pop.Config.canvasHeight * .8) -
    ((Pop.Config.canvasHeight * .8) * (@inflation / 100))
  [ideal - 7, ideal + 7]

Pop.Balloon.prototype.pop = ->
  Pop.sfxPop.play()
  @inflated = false
  @round.scoreKeeper.pops += 1
  @round.scoreKeeper["#{ @tense.camelize() }Pops"] += 1
  Pop.removeElementFrom this, @round.balloons
  @round.currentQuiz.close() if @round.currentQuiz
  @round.scoreKeeper.points += 10
  @round.handleCompletion()

Pop.Balloon.prototype.drop = ->
  @inflated = false
  @round.scoreKeeper.drops += 1
  @round.scoreKeeper["#{ @tense.camelize() }Drops"] += 1
  Pop.removeElementFrom this, @round.balloons
  if @round.currentQuiz && @round.currentQuiz.balloon == this
    @round.currentQuiz.close()
  @round.handleCompletion()

Pop.Balloon.prototype.drift = ->
  @xMomentum += (Math.random() - .5) / 5
  @yMomentum += (Math.random() - .5) / 5
  @xCoord += @xMomentum
  @yCoord += @yMomentum
  @inflation -= Math.random() / 50

Object.defineProperty Pop.Balloon.prototype, "inflation",
  get: ->
    @._inflation
  set: (amount) ->
    if amount >= 100
      @pop()
    else if amount <= 0
      @drop()
    else
      return @_inflation = amount

Object.defineProperty Pop.Balloon.prototype, "xCoord",
  get: ->
    @_xCoord
  set: (coord) ->
    if coord < 0
      @_xCoord = 0
    else if coord > Pop.Config.canvasWidth - 1
      @_xCoord = Pop.Config.canvasWidth - 1
    else
      @_xCoord = coord

Object.defineProperty Pop.Balloon.prototype, "yCoord",
  get: ->
    @_yCoord
  set: (coord) ->
    if coord < @yCoordRange()[0] + 15
      @yMomentum = (@yCoordRange()[0] - coord) / 10
    else if coord > @yCoordRange()[1] - 15
      @yMomentum = (@yCoordRange()[0] - coord) / 10
    else if coord < @yCoordRange()[0] + 9
      @yMomentum += Math.random() / 10
    else if coord > @yCoordRange()[1] - 9
      @yMomentum -= Math.random() / 10
    if coord < 0
      @_yCoord = 0
    else if coord > Pop.Config.canvasHeight - 1
      @_yCoord = Pop.Config.canvasHeight - 1
    else
      @_yCoord = coord

Object.defineProperty Pop.Balloon.prototype, "xMomentum",
  get: ->
    @_xMomentum
  set: (momentum) ->
    if momentum < -.5
      @_xMomentum = -.5
    else if momentum > .5
      @_xMomentum = .5
    else
      @_xMomentum = momentum

Object.defineProperty Pop.Balloon.prototype, "yMomentum",
  get: ->
    @_yMomentum
  set: (momentum) ->
    if momentum < -3
      @_yMomentum = -3
    else if momentum > 3
      @_yMomentum = 3
    else
      @_yMomentum = momentum
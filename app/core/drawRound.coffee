Pop.drawRound = (params) ->
  game = params.game
  currentRound = game.roundManager.currentRound

  project.activeLayer.removeChildren()

  balloons = for balloon in currentRound.balloons
    Pop.drawBalloon
      xCoord: balloon.xCoord
      yCoord: balloon.yCoord
      inflation: balloon.inflation
      tilt: balloon.xMomentum
      color: balloon.color
      balloon: balloon
      active: balloon.active

  Pop.drawLowerBox()

  text = currentRound.currentInfinitive

  if currentRound.currentQuiz
    text += " (" + currentRound.currentQuiz.tense + "): "
    text += currentRound.currentQuiz.currentQuestion().conjugation

  hint = Pop.drawWord
    text: text
    xCoord: Pop.Config.canvasWidth / 2
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 8 )
    fontSize: .8

  xRate = Pop.Config.canvasWidth / (game.currentLanguage().tenses.length)
  xCoord = xRate/4
  for tense in currentRound.tenses
    balloonDrawing = Pop.drawBalloon
      xCoord: xCoord
      yCoord: (Pop.Config.canvasHeight / 16)
      tilt: 0
      inflation: 25
      color: game.currentLanguage().colorForTense(tense)
    text = "#{currentRound.scoreKeeper.getPercentage(tense)}%"
    Pop["#{tense.camelize()}Percent"] = Pop.drawWord
      text: text
      xCoord: xCoord
      yCoord: Pop.Config.canvasHeight / 20
      fontSize: .3
    xCoord += xRate

  balloonTool = new Tool()
  balloonTool.onMouseDown = (event) ->
    hitResult = project.hitTest(event.point, Pop.HitOptions)
    if hitResult
      if hitResult.item.balloon
        hitResult.item.balloon.startQuiz()
    return

  view.onFrame = (event) ->
    for tense in currentRound.tenses
      Pop["#{tense.camelize()}Percent"].content =
        "#{currentRound.scoreKeeper.getPercentage(tense)}%"

    text = currentRound.currentInfinitive
    if currentRound.currentQuiz
      text += " (" + currentRound.currentQuiz.tense + "): "
      text += currentRound.currentQuiz.currentQuestion().conjugation

    hint.content = text

    for balloon in balloons
      if balloon
        balloon.remove()

    balloons = for balloon in currentRound.balloons
      if balloon
        balloon.drift()
        Pop.drawBalloon
          xCoord: balloon.xCoord
          yCoord: balloon.yCoord
          inflation: balloon.inflation
          tilt: balloon.xMomentum
          color: balloon.color
          balloon: balloon
          active: balloon.active

  balloonTool.activate()
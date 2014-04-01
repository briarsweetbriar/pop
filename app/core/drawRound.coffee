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

  question = Pop.drawWord
    text: text
    xCoord: Pop.Config.canvasWidth / 2
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 7.5 )
    fontSize: .8

  Pop.Hint = Pop.drawWord
    xCoord: Pop.Config.canvasWidth / 2
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 75 )
    fontSize: .5

  xRate = Pop.Config.canvasWidth / (game.currentLanguage().tenses.length)
  xCoord = xRate/4
  for tense in currentRound.tenses
    balloonDrawing = Pop.drawBalloon
      xCoord: xCoord
      yCoord: (Pop.Config.canvasHeight / 16)
      tilt: 0
      inflation: 25
      color: game.currentLanguage().colorForTense(tense)
    text = currentRound.scoreKeeper["#{tense.camelize()}Pops"]
    Pop["#{tense.camelize()}Pops"] = Pop.drawWord
      text: text
      xCoord: xCoord
      yCoord: Pop.Config.canvasHeight / 20
      fontSize: .3
    xCoord += xRate

  Pop.drawWord
    text: "Speed"
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 7.1)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 8)
    fontSize: .6

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 25),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 10)),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 9.8),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 20))
  )
  fastButton = new Path.Rectangle(rectangle)
  if Pop.Config.speed == Pop.Config.fastSpeed
    fastButton.fillColor = '#FE999B'
  else
    fastButton.fillColor = '#FD777A'
  fastButton.strokeColor = '#BE7274'
  fastButton.isFastButton = true

  fastButtonText = Pop.drawWord
    text: "fast"
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 14)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 15)
    fontSize: .45
  fastButtonText.isFastButton = true

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 9),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 10)),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 5.8),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 20))
  )
  mediumButton = new Path.Rectangle(rectangle)
  if Pop.Config.speed == Pop.Config.mediumSpeed
    mediumButton.fillColor = '#FE999B'
  else
    mediumButton.fillColor = '#FD777A'
  mediumButton.strokeColor = '#BE7274'
  mediumButton.isMediumButton = true

  mediumButtonText = Pop.drawWord
    text: "norm."
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 7.1)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 15)
    fontSize: .4
  mediumButtonText.isMediumButton = true

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 5.5),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 10)),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 4),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 20))
  )
  slowButton = new Path.Rectangle(rectangle)
  if Pop.Config.speed == Pop.Config.slowSpeed
    slowButton.fillColor = '#FE999B'
  else
    slowButton.fillColor = '#FD777A'
  slowButton.strokeColor = '#BE7274'
  slowButton.isSlowButton = true

  slowButtonText = Pop.drawWord
    text: "slow"
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 4.6)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 15)
    fontSize: .45
  slowButtonText.isSlowButton = true

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 70),
      Pop.Config.canvasHeight * .01),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 15),
      Pop.Config.canvasHeight * .06)
  )
  menuButton = new Path.Rectangle(rectangle)
  menuButton.fillColor = '#FD777A'
  menuButton.strokeColor = '#BE7274'
  menuButton.isMenuButton = true

  menuButtonText = Pop.drawWord
    text: "Menu"
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 25)
    yCoord: Pop.Config.canvasHeight * .0425
    fontSize: .3
  menuButtonText.isMenuButton = true

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 70),
      Pop.Config.canvasHeight * .07),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 15),
      Pop.Config.canvasHeight * .12)
  )
  soundButton = new Path.Rectangle(rectangle)
  soundButton.fillColor = '#FD777A'
  soundButton.strokeColor = '#BE7274'
  soundButton.isSoundButton = true

  text = if Pop.Config.muted then "Unmute" else "Mute"
  soundButtonText = Pop.drawWord
    text: text
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 25)
    yCoord: Pop.Config.canvasHeight * .102
    fontSize: .27
  soundButtonText.isSoundButton = true

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth / 18,
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 5.5)),
    new Point((Pop.Config.canvasHeight / 15) * 5.4,
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 75))
  )
  instructionBox = new Path.Rectangle(rectangle)
  instructionBox.fillColor = "#FFD177"
  instructionBox.strokeColor = "#BFA573"

  Pop.drawWord
    text: "English keyboards:"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 7)
    fontSize: .35
    justification: "left"

  Pop.drawWord
    text: "é = ' + e"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 9)
    fontSize: .3
    justification: "left"

  Pop.drawWord
    text: "ü = ; + u"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 12)
    fontSize: .3
    justification: "left"

  Pop.drawWord
    text: "ñ = ~ + n"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 19)
    fontSize: .3
    justification: "left"

  Pop.drawWord
    text: "skip = ctrl"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 40)
    fontSize: .3
    justification: "left"

  resetSpeedColors = ->
    fastButton.fillColor = '#FD777A'
    mediumButton.fillColor = '#FD777A'
    slowButton.fillColor = '#FD777A'

  balloonTool = new Tool()
  balloonTool.onMouseDown = (event) ->
    hitResult = project.hitTest(event.point, Pop.HitOptions)
    if hitResult
      if hitResult.item.balloon
        hitResult.item.balloon.startQuiz()
      else if hitResult.item.isFastButton
        Pop.Config.speed = Pop.Config.fastSpeed
        resetSpeedColors()
        fastButton.fillColor = '#FE999B'
      else if hitResult.item.isMediumButton
        Pop.Config.speed = Pop.Config.mediumSpeed
        resetSpeedColors()
        mediumButton.fillColor = '#FE999B'
      else if hitResult.item.isSlowButton
        Pop.Config.speed = Pop.Config.slowSpeed
        resetSpeedColors()
        slowButton.fillColor = '#FE999B'
      else if hitResult.item.isMenuButton
        currentRound.complete()
      else if hitResult.item.isSoundButton
        if Pop.Config.muted
          Pop.backgroundMusic.play()
          Pop.Config.muted = false
          soundButtonText.content = "Mute"
        else
          Pop.backgroundMusic.pause()
          Pop.Config.muted = true
          soundButtonText.content = "Unmute"
    return

  view.onFrame = (event) ->
    for tense in currentRound.tenses
      Pop["#{tense.camelize()}Pops"].content =
        currentRound.scoreKeeper["#{tense.camelize()}Pops"]

    text = currentRound.currentInfinitive
    if currentRound.currentQuiz
      text += " (" + currentRound.currentQuiz.tense + "): "
      text += currentRound.currentQuiz.currentQuestion().conjugation

    question.content = text

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
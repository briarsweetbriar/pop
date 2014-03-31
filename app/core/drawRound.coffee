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
  fastButton.fillColor = '#FD777A'
  fastButton.strokeColor = '#BE7274'
  fastButton.isFastButton = true
  fastButton.onMouseEnter = ->
    @fillColor = '#FE999B'
  fastButton.onMouseLeave = ->
    @fillColor = '#FD777A'

  fastButton = Pop.drawWord
    text: ">>"
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 14)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 15)
    fontSize: .45
  fastButton.isFastButton = true

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 9),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 10)),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 5.8),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 20))
  )
  mediumButton = new Path.Rectangle(rectangle)
  mediumButton.fillColor = '#FD777A'
  mediumButton.strokeColor = '#BE7274'
  mediumButton.isMediumButton = true
  mediumButton.onMouseEnter = ->
    @fillColor = '#FE999B'
  mediumButton.onMouseLeave = ->
    @fillColor = '#FD777A'

  mediumButton = Pop.drawWord
    text: "reset"
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 7.1)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 15)
    fontSize: .45
  mediumButton.isMediumButton = true

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 5.5),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 10)),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 4),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 20))
  )
  slowButton = new Path.Rectangle(rectangle)
  slowButton.fillColor = '#FD777A'
  slowButton.strokeColor = '#BE7274'
  slowButton.isSlowButton = true
  slowButton.onMouseEnter = ->
    @fillColor = '#FE999B'
  slowButton.onMouseLeave = ->
    @fillColor = '#FD777A'

  slowButton = Pop.drawWord
    text: "<<"
    xCoord: Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 4.6)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 15)
    fontSize: .45
  slowButton.isSlowButton = true

  rectangle = new Rectangle(
    new Point(Pop.Config.canvasWidth / 18,
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 5.5)),
    new Point((Pop.Config.canvasHeight / 15) * 4.5,
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 35))
  )
  instructionBox = new Path.Rectangle(rectangle)
  instructionBox.fillColor = "#FFD177"
  instructionBox.strokeColor = "#BFA573"

  Pop.drawWord
    text: "é = ' + e"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 7)
    fontSize: .45
    justification: "left"

  Pop.drawWord
    text: "ü = ; + u"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 9)
    fontSize: .45
    justification: "left"

  Pop.drawWord
    text: "ñ = ~ + n"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 13)
    fontSize: .45
    justification: "left"

  Pop.drawWord
    text: "skip = ctrl"
    xCoord: Pop.Config.canvasWidth / 15
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 24)
    fontSize: .45
    justification: "left"

  balloonTool = new Tool()
  balloonTool.onMouseDown = (event) ->
    hitResult = project.hitTest(event.point, Pop.HitOptions)
    if hitResult
      if hitResult.item.balloon
        hitResult.item.balloon.startQuiz()
      else if hitResult.item.isFastButton
        Pop.Config.speed *= Pop.Config.fastSpeed
      else if hitResult.item.isMediumButton
        Pop.Config.speed = Pop.Config.mediumSpeed
      else if hitResult.item.isSlowButton
        Pop.Config.speed *= Pop.Config.slowSpeed
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
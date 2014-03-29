Pop.drawRoundMenu = (params) ->

  game = params.game

  xRate = Pop.Config.canvasWidth / (game.currentLanguage().tenses.length)

  drawBalloons = ->
    xCoord = xRate/2
    for balloon in tenseBalloons
      balloon.drift()
      balloon.inflation = if chosenTenses.indexOf(balloon.tense) >= 0
        70
      else
        20
      if balloon.xCoord < xCoord - 10
        balloon.xCoord = xCoord - 10
        balloon.xMomentum = .1
      else if balloon.xCoord > xCoord + 10
        balloon.xCoord = xCoord + 10
        balloon.xMomentum = -.1
      balloonDrawing = Pop.drawBalloon
        xCoord: balloon.xCoord
        yCoord: balloon.yCoord
        tilt: balloon.xMomentum
        inflation: 40
        color: balloon.color
      balloonDrawing.tense = balloon.tense
      balloons.push balloonDrawing
      xCoord += xRate

  colorContinueButton = ->
    continueButton.strokeColor = '#BE7274'
    continueButton.fillColor = if chosenTenses.length > 0
      '#FD777A'
    else
      '#BE7274'

  tenseBalloons = []
  for tense in game.currentLanguage().tenses
    tenseBalloons.push new Pop.Balloon(
      tense: tense
      inflation: Pop.getRandomInt(22, 35)
    )

  chosenTenses = []

  project.activeLayer.removeChildren()

  Pop.drawLowerBox()

  rectangle = new Rectangle(
    new Point(0 + (Pop.Config.canvasWidth / 20),
      Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 4) - (Pop.Config.canvasHeight / 10))),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 20),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 20)))
  continueButton = new Path.Rectangle(rectangle)
  continueButton.onMouseEnter = ->
    if chosenTenses.length > 0
      @fillColor = '#FE999B'
  continueButton.onMouseLeave = ->
    if chosenTenses.length > 0
      @fillColor = '#FD777A'

  xCoord = xRate/2
  for tense in game.currentLanguage().tenses
    balloonDrawing = Pop.drawBalloon
      xCoord: xCoord
      yCoord: (Pop.Config.canvasHeight / 16)
      tilt: 0
      inflation: 25
      color: game.currentLanguage().colorForTense(tense)
    text = "#{game.scoreKeeper.getPercentage(tense)}%"
    Pop["#{tense.camelize()}Percent"] = Pop.drawWord
      text: text
      xCoord: xCoord
      yCoord: Pop.Config.canvasHeight / 20
      fontSize: .3
    xCoord += xRate

  balloons = []
  drawBalloons()
  
  xCoord = xRate/2
  for balloon in tenseBalloons
    Pop.drawWord
      text: balloon.tense
      xCoord: xCoord
      yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 6)
      fontSize: .3
    xCoord += xRate

  colorContinueButton()
  Pop.drawWord
    text: "Continue"
    xCoord: (Pop.Config.canvasWidth / 2)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 13)
  view.draw()

  newRoundButtons = new Tool()
  newRoundButtons.onMouseDown = (event) ->
    hitResult = project.hitTest(event.point, Pop.HitOptions)
    if hitResult
      tense = hitResult.item.tense
      if tense
        if chosenTenses.indexOf(tense) >= 0
          Pop.removeElementFrom tense, chosenTenses
        else
          chosenTenses.push tense
        colorContinueButton()
      else
        if chosenTenses.length > 0
          view.onFrame = null
          game.roundManager.newRound({ game: game, tenses: chosenTenses })
    return

  view.onFrame = (event) ->

    for balloon in balloons
      balloon.remove()

    drawBalloons()

  newRoundButtons.activate()
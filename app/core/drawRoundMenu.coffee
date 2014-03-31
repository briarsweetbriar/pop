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
  
  mascot = new Raster('mascot-image')
  mascot.position = view.center
  mascot.position.y -= Pop.Config.canvasHeight / 10

  rectangle = new Rectangle(
    new Point((Pop.Config.canvasWidth / 2) + 175,
      Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 2) + (Pop.Config.canvasHeight / 5))),
    new Point((Pop.Config.canvasWidth / 2) + 235,
      Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 2) + (Pop.Config.canvasHeight / 8))))
  instructionBox = new Path.Rectangle(rectangle)
  instructionBox.isInstructionBox = true
  instructionBox.fillColor = "#fff"
  instructionLink1 = Pop.drawWord
    text: "Click here"
    xCoord: (Pop.Config.canvasWidth / 2) + 208
    yCoord: Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 2) + (Pop.Config.canvasHeight / 6))
    fontSize: .35
  instructionLink1.isInstructionBox = true
  instructionLink2 = Pop.drawWord
    text: "for help"
    xCoord: (Pop.Config.canvasWidth / 2) + 208
    yCoord: Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 2) + (Pop.Config.canvasHeight / 7.5))
    fontSize: .3
  instructionLink2.isInstructionBox = true

  Pop.drawWord
    text: "#{game.scoreKeeper.pops} pops"
    xCoord: (Pop.Config.canvasWidth / 2) - 208
    yCoord: Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 2) + (Pop.Config.canvasHeight / 6))
    fontSize: .3
  Pop.drawWord
    text: "in #{game.scoreKeeper.rounds} rounds"
    xCoord: (Pop.Config.canvasWidth / 2) - 208
    yCoord: Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 2) + (Pop.Config.canvasHeight / 7.5))
    fontSize: .3

  Pop.drawLowerBox()

  rectangle = new Rectangle(
    new Point(0 + (Pop.Config.canvasWidth / 20),
      Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 4) - (Pop.Config.canvasHeight / 10))),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 20),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 20)))
  continueButton = new Path.Rectangle(rectangle)
  continueButton.isContinueButton = true
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
    text = game.scoreKeeper["#{tense.camelize()}Pops"]
    Pop.drawWord
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
    text: "continue"
    xCoord: (Pop.Config.canvasWidth / 2)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 13)
  view.draw()

  Pop.drawWord
    text: "select balloons to pop"
    xCoord: Pop.Config.canvasWidth / 2
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 65 )
    fontSize: .3
    color: '#777'

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
      else if hitResult.item.isInstructionBox
        alert "Welcome to POP! Your goal is to pop as many balloons as possible. On this screen, select the tenses you want to practice. Once you're ready, click 'Continue'. You'll see a screen full of balloons, as well as a text field at the bottom. Each balloon represents a tense, and when you click on it, you'll be asked to conjugate a verb in its tense. Every correct answer inflates the balloon, while incorrect answers deflate it. If you fill the balloon with enough air, it'll pop, but if it loses too much air, it'll fall off the screen. All the while, your balloons are steadily losing air. You've got to answer fast or they'll all disappear!"
      else if hitResult.item.isContinueButton
        if chosenTenses.length > 0
          view.onFrame = null
          game.roundManager.newRound({ game: game, tenses: chosenTenses })
    return

  view.onFrame = (event) ->

    for balloon in balloons
      balloon.remove()

    drawBalloons()

  newRoundButtons.activate()
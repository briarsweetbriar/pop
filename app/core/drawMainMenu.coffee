Pop.drawMainMenu = (params) ->
  game = params.game

  instructions = Pop.drawWord
    text: "POP"
    xCoord: Pop.Config.canvasWidth / 2
    yCoord: Pop.Config.canvasHeight / 2.5
    fontSize: 5
  
  Pop.drawLowerBox()

  rectangle = new Rectangle(
    new Point(0 + (Pop.Config.canvasWidth / 20),
      Pop.Config.canvasHeight - ((Pop.Config.canvasHeight / 4) - (Pop.Config.canvasHeight / 10))),
    new Point(Pop.Config.canvasWidth - (Pop.Config.canvasWidth / 20),
      Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 20)))
  startButton = new Path.Rectangle(rectangle)
  startButton.fillColor = '#FD777A'
  startButton.strokeColor = '#BE7274'
  startButton.onMouseEnter = ->
    @fillColor = '#FE999B'
  startButton.onMouseLeave = ->
    @fillColor = '#FD777A'
  Pop.drawWord
    text: "start"
    xCoord: (Pop.Config.canvasWidth / 2)
    yCoord: Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 13)
  view.draw()

  mainMenuButtons = new Tool()
  mainMenuButtons.onMouseDown = (event) ->
    hitResult = project.hitTest(event.point, Pop.HitOptions)
    if hitResult
      Pop.drawRoundMenu game: game
    return

  mainMenuButtons.activate()
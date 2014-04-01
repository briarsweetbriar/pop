Pop.drawMainMenu = (params) ->
  game = params.game

  Pop.drawWord
    text: "POP"
    xCoord: Pop.Config.canvasWidth / 2
    yCoord: Pop.Config.canvasHeight / 2.5
    fontSize: 5

  Pop.drawWord
    text: "(click to start)"
    xCoord: Pop.Config.canvasWidth / 2
    yCoord: Pop.Config.canvasHeight / 1.5
    fontSize: .5
  view.draw()

  mainMenuButtons = new Tool()
  mainMenuButtons.onMouseDown = (event) ->
    Pop.drawRoundMenu game: game
    return

  mainMenuButtons.activate()
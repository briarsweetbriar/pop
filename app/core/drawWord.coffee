Pop.drawWord = (params) ->
  fontSize = params.fontSize || 1
  new PointText
    point: new Point(params.xCoord, params.yCoord)
    content: params.text
    fontSize: (Pop.Config.canvasHeight / 15) * fontSize
    fillColor: '#424134'
    justification: 'center'
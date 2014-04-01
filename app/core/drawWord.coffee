Pop.drawWord = (params) ->
  fontSize = params.fontSize || 1
  new PointText
    point: new Point(params.xCoord, params.yCoord)
    content: params.text
    fontSize: "#{(Pop.Config.canvasHeight / 15) * fontSize}px"
    fillColor: params.color || '#424134'
    justification: params.justification || 'center'
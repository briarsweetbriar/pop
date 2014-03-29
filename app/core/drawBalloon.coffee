Pop.drawBalloon = (params) ->
  xCoord = params.xCoord
  yCoord = params.yCoord
  inflation = params.inflation * (Pop.Config.canvasHeight / 700)
  strokeColor = if params.active then "#eee" else "rgba(200, 200, 200, .3)"
  strokeWidth = if params.active then 3 else 1
  path = new Path(
    segments: [
      [ xCoord - inflation + (inflation / 1.75), yCoord + inflation ],
      [ xCoord - (inflation * 1.1), yCoord - (inflation * .8) ],
      [ xCoord, yCoord - (inflation * 1.65) ],
      [ xCoord + (inflation * 1.1), yCoord - (inflation * .8) ],
      [ xCoord + inflation - (inflation / 1.75), yCoord + inflation ]
    ]
    strokeColor: strokeColor
    strokeWidth: strokeWidth
    fillColor: params.color
    closed: true
  )
  path.balloon = params.balloon
  path.smooth()
  path.rotate(params.tilt * 7)
  path
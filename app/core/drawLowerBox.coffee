Pop.drawLowerBox = ->
  rectangle = new Rectangle(new Point(0, Pop.Config.canvasHeight - (Pop.Config.canvasHeight / 5)),
    new Point(Pop.Config.canvasWidth, Pop.Config.canvasHeight))
  rectanglePath = new Path.Rectangle(rectangle)
  rectanglePath.fillColor = "#9CDDDA"
  rectanglePath.strokeColor = "#84DDD9"
Pop = Pop || {}

Pop.Config =
  canvasWidth: this.canvasWidth
  canvasHeight: this.canvasHeight
  defaultBalloonCount: 10
  inflationRate: 10
  deflationRate: 7

Pop.HitOptions =
  segments: true
  stroke: true
  fill: true
  tolerance: 5
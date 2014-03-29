Pop = Pop || {}

Pop.Config =
  canvasWidth: this.canvasWidth || 840
  canvasHeight: this.canvasHeight || 600
  defaultBalloonCount: 10
  inflationRate: 10
  deflationRate: 3

Pop.HitOptions =
  segments: true
  stroke: true
  fill: true
  tolerance: 5
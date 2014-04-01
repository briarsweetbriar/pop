Pop = Pop || {}

Pop.Config =
  canvasWidth: this.canvasWidth
  canvasHeight: this.canvasHeight
  spashTimes: 3
  defaultBalloonCount: 10
  inflationRate: 10
  deflationRate: 7
  speed: .01
  slowSpeed: .005
  mediumSpeed: .01
  fastSpeed: .015
  muted: false

Pop.HitOptions =
  segments: true
  stroke: true
  fill: true
  tolerance: 5
Pop = Pop || {}

Pop.Config =
  canvasWidth: this.canvasWidth
  canvasHeight: this.canvasHeight
  spashTimes: 1500
  defaultBalloonCount: 10
  inflationRate: 10
  deflationRate: 7
  speed: .01
  slowSpeed: .5
  mediumSpeed: .01
  fastSpeed: 2

Pop.HitOptions =
  segments: true
  stroke: true
  fill: true
  tolerance: 5
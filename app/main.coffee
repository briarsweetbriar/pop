INFLATION_RATE = 10

game = new Game

for language in rawLanguages
  game.languages.push new Language language
  game.currentLanguage = game.languages[0]

paper.install(window)

window.onload = ->

  popDOM = document.createElement('canvas')
  popDOM.id = "pop-canvas"
  popDOM.width = "640"
  popDOM.height = "480"

  document.getElementById("pop-container").appendChild(popDOM)

  canvas = document.getElementById('pop-canvas')
  paper.setup(canvas)
  myPath = new Path()
  myPath.strokeColor = 'black'
  myPath.add(new Point(0, 0))
  myPath.add(new Point(100, 50))
  view.draw()
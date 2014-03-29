paper.install(window)

window.onload = ->

  Pop.game = new Pop.Game()

  Pop.container = document.getElementById("pop-container")
  Pop.Config.canvasWidth = Pop.container.parentNode.offsetWidth
  Pop.Config.canvasHeight = Pop.container.parentNode.offsetHeight
  if Pop.Config.canvasHeight < 10
    Pop.Config.canvasHeight = window.innerHeight

  Pop.style = document.createElement('style')
  Pop.style.type = 'text/css'
  Pop.style.innerHTML = '#pop-container { position: relative;'
  Pop.style.innerHTML += ' width: ' + Pop.Config.canvasWidth  + 'px;'
  Pop.style.innerHTML += ' height: ' + Pop.Config.canvasHeight + 'px;'
  Pop.style.innerHTML += ' overflow: hidden; '
  Pop.style.innerHTML += ' background: #57BAB6; }'

  Pop.style.innerHTML += '.pop-hidden { display: none; }'

  Pop.style.innerHTML += '#pop-input { position: absolute; font-size: 98%;'
  Pop.style.innerHTML += ' width: 33%; height: 5%; bottom: 4%; left: 33%;'
  Pop.style.innerHTML += ' border-radius: 0; padding-left: 1%;}'
  document.getElementsByTagName('head')[0].appendChild(Pop.style)

  Pop.canvas = document.createElement('canvas')
  Pop.canvas.id = "pop-canvas"
  Pop.canvas.width = Pop.Config.canvasWidth
  Pop.canvas.height = Pop.Config.canvasHeight

  Pop.form = document.createElement('form')
  Pop.form.id = "pop-form"
  Pop.form.className = "pop-hidden"
  Pop.form.onsubmit = (e) ->
    e = e || window.event
    e.preventDefault()
    e.returnValue = false
    Pop.game.roundManager.currentRound.currentQuiz.submitAnswer Pop.Input.get()

  Pop.input = document.createElement('input')
  Pop.input.id = "pop-input"

  Pop.container.appendChild(Pop.canvas)
  Pop.container.appendChild(Pop.form)
  document.getElementById("pop-form").appendChild(Pop.input)

  paper.setup(Pop.canvas)

  Pop.backgroundMusic = new Audio("pop-assets/background-music.wav")
  Pop.sfxPop = new Audio("pop-assets/sfx-pop.wav")
  Pop.sfxInflate = new Audio("pop-assets/sfx-inflate.wav")
  Pop.sfxDeflate = new Audio("pop-assets/sfx-deflate.wav")

  if typeof Pop.backgroundMusic.loop == 'boolean'
    Pop.backgroundMusic.loop = true
  else
    Pop.backgroundMusic.addEventListener('ended', ->
      @currentTime = 0
      @play()
    , false)

  Pop.backgroundMusic.play()

  Pop.drawMainMenu({ game: Pop.game })
Pop.AccentHandler =
  accentActivated: false
  diaeresisActivated: false
  tildeActivated: false

  replaceLastCharWith: (char) ->
    setTimeout((->
      newValue = Pop.Input.get().slice(0,-1) + char
      Pop.Input.replace(newValue)
    ), 1)

document.addEventListener "keydown", (e) ->
  if document.getElementById("pop-input") == document.activeElement
    if e.keyCode is 17
      Pop.game.roundManager.currentRound.currentQuiz.nextQuestion()

document.addEventListener "keypress", (e) ->
  if document.getElementById("pop-input") == document.activeElement
    char = String.fromCharCode(e.charCode)
    if char is "~" || char is "`"
      Pop.AccentHandler.tildeActivated = true
      Pop.AccentHandler.replaceLastCharWith ""
    else if char is "'" || char is "\""
      Pop.AccentHandler.accentActivated = true
      Pop.AccentHandler.replaceLastCharWith ""
    else if char is ":" || char is ";"
      Pop.AccentHandler.diaeresisActivated = true
      Pop.AccentHandler.replaceLastCharWith ""
    else if e.keyCode != 16
      if Pop.AccentHandler.accentActivated == true
        Pop.AccentHandler.accentActivated = false
        switch char
          when "A" then Pop.AccentHandler.replaceLastCharWith "Á"
          when "E" then Pop.AccentHandler.replaceLastCharWith "É"
          when "I" then Pop.AccentHandler.replaceLastCharWith "Í"
          when "O" then Pop.AccentHandler.replaceLastCharWith "Ó"
          when "U" then Pop.AccentHandler.replaceLastCharWith "Ú"
          when "a" then Pop.AccentHandler.replaceLastCharWith "á"
          when "e" then Pop.AccentHandler.replaceLastCharWith "é"
          when "i" then Pop.AccentHandler.replaceLastCharWith "í"
          when "o" then Pop.AccentHandler.replaceLastCharWith "ó"
          when "u" then Pop.AccentHandler.replaceLastCharWith "ú"
      else if Pop.AccentHandler.diaeresisActivated == true
        Pop.AccentHandler.diaeresisActivated = false
        if char == "U" then Pop.AccentHandler.replaceLastCharWith "Ü"
        else if char == "u" then Pop.AccentHandler.replaceLastCharWith "ü"
      else if Pop.AccentHandler.tildeActivated == true
        Pop.AccentHandler.tildeActivated = false
        if char == "N" then Pop.AccentHandler.replaceLastCharWith "Ñ"
        else if char == "n" then Pop.AccentHandler.replaceLastCharWith "ñ"
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
    if e.keyCode is 192
      Pop.AccentHandler.tildeActivated = true
      Pop.AccentHandler.replaceLastCharWith ""
    else if e.keyCode is 222
      Pop.AccentHandler.accentActivated = true
      Pop.AccentHandler.replaceLastCharWith ""
    else if e.keyCode is 59
      Pop.AccentHandler.diaeresisActivated = true
      Pop.AccentHandler.replaceLastCharWith ""
    else if e.keyCode != 16
      if Pop.AccentHandler.accentActivated == true
        Pop.AccentHandler.accentActivated = false
        if e.shiftKey
          switch e.keyCode
            when 65 then Pop.AccentHandler.replaceLastCharWith "Á"
            when 69 then Pop.AccentHandler.replaceLastCharWith "É"
            when 73 then Pop.AccentHandler.replaceLastCharWith "Í"
            when 79 then Pop.AccentHandler.replaceLastCharWith "Ó"
            when 85 then Pop.AccentHandler.replaceLastCharWith "Ú"
        else
          switch e.keyCode
            when 65 then Pop.AccentHandler.replaceLastCharWith "á"
            when 69 then Pop.AccentHandler.replaceLastCharWith "é"
            when 73 then Pop.AccentHandler.replaceLastCharWith "í"
            when 79 then Pop.AccentHandler.replaceLastCharWith "ó"
            when 85 then Pop.AccentHandler.replaceLastCharWith "ú"
      else if Pop.AccentHandler.diaeresisActivated == true
        Pop.AccentHandler.diaeresisActivated = false
        if e.keyCode == 85
          if e.shiftKey
            Pop.AccentHandler.replaceLastCharWith "Ü"
          else
            Pop.AccentHandler.replaceLastCharWith "ü"
      else if Pop.AccentHandler.tildeActivated == true
        Pop.AccentHandler.tildeActivated = false
        if e.keyCode == 78
          if e.shiftKey
            Pop.AccentHandler.replaceLastCharWith "Ñ"
          else
            Pop.AccentHandler.replaceLastCharWith "ñ"
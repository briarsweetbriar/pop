Pop.drawHint = (hint) ->
  Pop.Hint.content = hint
  Pop.Hint.fillColor = "#BE7274"

Pop.removeHint = ->
  Pop.Hint.content = "`ú` = `'` + 'u'; `ü` = `:` + `u`; `ñ` = `~` + `n`"
  Pop.Hint.fillColor = '#777'
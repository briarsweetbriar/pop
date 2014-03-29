Pop.Input =

  hide: ->
    if document.getElementById("pop-input")
      document.getElementById("pop-form").className = "pop-hidden"
      return

  show: ->
    if document.getElementById("pop-input")
      document.getElementById("pop-form").className = ""
      setTimeout((->
        document.getElementById("pop-input").focus()
      ), 5)
      return

  get: ->
    if document.getElementById("pop-input")
      document.getElementById("pop-input").value

  replace: (newValue) ->
    document.getElementById("pop-input").value = newValue

  clear: ->
    if document.getElementById("pop-input")
      document.getElementById("pop-input").value = ""
      return
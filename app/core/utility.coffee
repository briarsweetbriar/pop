Pop.getRandomInt = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min

Pop.getRandomElement = (array) ->
  array[Math.floor(Math.random() * array.length)]

Pop.removeElementFrom = (element, array) ->
  index = array.indexOf element
  array.splice(index, 1)

String.prototype.camelize = ->
  @replace(/(\-|_|\.|\s)+(.)?/g, (match, separator, chr) ->
    if chr then chr.toUpperCase() else ''
  ).replace(/^([A-Z])/, (match, separator, chr) ->
    match.toLowerCase()
  )
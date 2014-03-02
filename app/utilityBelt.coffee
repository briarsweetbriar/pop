getRandom = (array) ->
  array[Math.floor(Math.random() * array.length)]

Array.prototype.remove = (element) ->
  index = this.indexOf element
  this.splice(index, 1)
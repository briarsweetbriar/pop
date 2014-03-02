Question = (params) ->
  this.conjugation = game.currentLanguage.findConjugation params.key
  this.answer = params.value

  return

Question.prototype.checkAnswer = (answer) ->
  return true if answer == this.answer
  return false
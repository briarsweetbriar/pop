Pop.Question = (params) ->
  @game = params.game
  @conjugation = @game.currentLanguage().findConjugation params.key
  @answer = params.value
  @attemptsRemaining = 2

  return

Pop.Question.prototype.checkAnswer = (answer) ->
  return true if answer == @answer
  return false
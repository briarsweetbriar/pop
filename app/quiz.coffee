Quiz = (params) ->
  this.tense = params.tense
  this.balloon = params.balloon
  this.infinitive = params.infinitive
  this.verb = game.currentLanguage.findVerbByInfinitive this.infinitive

  this.questions = []

  for key, value of this.verb[this.tense]
    this.questions.push new Question { key: key, value: value }

  this.correctAnswers = 0
  this.wrongAnswers = 0
  this.pendingAnswers = this.questions.length

  this.currentQuestionLocation = 0

  return

Quiz.prototype.currentQuestion = ->
  this.questions[this.currentQuestionLocation]

Quiz.prototype.firstQuestion = ->
  this.currentQuestionLocation = 0
  return this.currentQuestion()

Quiz.prototype.nextQuestion = ->
  this.currentQuestionLocation++
  if this.currentQuestionLocation <= this.questions.length
    return this.currentQuestion()
  else
    this.close()

Quiz.prototype.submitAnswer = (answer) ->
  if this.balloon.inflated == true
    if this.currentQuestion().checkAnswer(answer)
      this.correctAnswers += 1
      this.balloon.inflation += INFLATION_RATE
    else
      this.wrongAnswers += 1
      this.balloon.inflation -= INFLATION_RATE
    this.pendingAnswers -= 1
    this.nextQuestion()

Quiz.prototype.close = ->
  delete game.currentRound.currentQuiz
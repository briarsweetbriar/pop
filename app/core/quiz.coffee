Pop.Quiz = (params) ->
  @game = params.game
  @tense = params.tense
  @balloon = params.balloon
  @infinitive = params.infinitive
  @verb = @game.currentLanguage().findVerbByInfinitive @infinitive

  @answered = []

  @questions = []

  for key, value of @verb.tenses[@tense]
    @questions.push new Pop.Question { game: @game, key: key, value: value }

  @correctAnswers = 0
  @wrongAnswers = 0
  @pendingAnswers = @questions.length

  @currentQuestionLocation = Pop.getRandomInt(0, @questions.length - 1)

  return

Pop.Quiz.prototype.currentQuestion = ->
  @questions[@currentQuestionLocation]

Pop.Quiz.prototype.firstQuestion = ->
  @setNewLocation()
  @currentQuestion()

Pop.Quiz.prototype.nextQuestion = ->
  @answered.push(@currentQuestionLocation)
  if @setNewLocation() >= 0
    @currentQuestion()
  else
    @close()

Pop.Quiz.prototype.setNewLocation = ->
  candidates = []
  for question in @questions
    unless @answered.indexOf(@questions.indexOf(question)) >= 0
      candidates.push(question)
  candidate = Pop.getRandomElement(candidates)
  @currentQuestionLocation = @questions.indexOf(candidate)  

Pop.Quiz.prototype.prepNextQuestion = ->
  Pop.Input.clear()
  @pendingAnswers -= 1
  @nextQuestion()

Pop.Quiz.prototype.submitAnswer = (answer) ->
  Pop.removeHint()
  currentQuestion = @currentQuestion()
  if currentQuestion.checkAnswer(answer)
    @correctAnswers += 1
    @balloon.inflation += Pop.Config.inflationRate
    Pop.sfxInflate.play() if @balloon.inflated && !Pop.Config.muted
    @prepNextQuestion()
  else
    Pop.sfxDeflate.play() if !Pop.Config.muted
    @wrongAnswers += 1
    @balloon.inflation -= Pop.Config.deflationRate
    if currentQuestion.attemptsRemaining > 0
      currentQuestion.attemptsRemaining -= 1
      if currentQuestion.attemptsRemaining == 0
        Pop.drawHint(currentQuestion.answer)
    else
      @prepNextQuestion()

Pop.Quiz.prototype.close = ->
  @game.roundManager.currentRound.setCurrentInfinitive()
  @game.roundManager.currentRound.currentQuiz = undefined
  @balloon.active = false
  Pop.Input.clear()
  if @balloon.inflated
    @balloon.startQuiz() 
  else
    @game.roundManager.currentRound.selectLowestBalloon()
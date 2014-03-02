module "Quiz Tests"

test "quizzes have a tense, infinitive, and verb", ->
  quiz = new Quiz({ tense: "present", infinitive: "to err" })
  deepEqual(quiz.tense, "present", "returns the quiz's tense")
  deepEqual(quiz.infinitive, "to err", "returns the quiz's infinitive")
  deepEqual(quiz.verb.infinitive, "to err", "returns the quiz's verb")

test "quizzes ask a series of conjugation questions for the verb", ->
  quiz = new Quiz({ tense: "present", infinitive: "to err" })
  deepEqual(quiz.firstQuestion().answer, "I err", "returns first question")
  deepEqual(quiz.nextQuestion().answer, "you err", "returns next question (1)")
  deepEqual(quiz.nextQuestion().answer, "he errs", "returns next question (2)")
  deepEqual(quiz.nextQuestion().answer, "we err", "returns next question (3)")
  deepEqual(quiz.nextQuestion().answer, "y'all err", "returns next question (4)")
  deepEqual(quiz.nextQuestion().answer, "they err", "returns next question (5)")

test "quizzes adjust balloon inflation for correct and incorrect answers", ->
  game.currentRound.currentInfinitive = "to err"
  balloon = new Balloon({ tense: "present", inflation: 50 })
  quiz = balloon.startQuiz()
  quiz.submitAnswer("I err")
  deepEqual(
    balloon.inflation,
    50 + INFLATION_RATE,
    "correct answers inflate the balloon"
  )
  quiz.submitAnswer("incorrect answer")
  quiz.submitAnswer("another incorrect answer")
  deepEqual(
    balloon.inflation,
    50 - INFLATION_RATE,
    "wrong answers deflate the balloon"
  )
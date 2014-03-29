module "Quiz Tests"

test "Quiz has properties", ->
  game = new Pop.Game()
  quiz = new Pop.Quiz({ game: game, tense: "Present", infinitive: "acostar" })
  ok(quiz.game instanceof Pop.Game, "game")
  equal(quiz.tense, "Present", "tense")
  equal(quiz.infinitive, "acostar", "infinitive")
  equal(quiz.verb.infinitive, "acostar", "verb")

test "quizzes ask a series of conjugation questions for the verb", ->
  game = new Pop.Game()
  quiz = new Pop.Quiz({ game: game, tense: "Present", infinitive: "acostar" })
  equal(quiz.firstQuestion().answer, "acuesto", "returns first question")
  equal(quiz.nextQuestion().answer, "acuestas", "returns next question (1)")
  equal(quiz.nextQuestion().answer, "acuesta", "returns next question (2)")
  equal(quiz.nextQuestion().answer, "acostamos", "returns next question (3)")
  equal(quiz.nextQuestion().answer, "acostáis", "returns next question (4)")
  equal(quiz.nextQuestion().answer, "acuestan", "returns next question (5)")

test "quizzes adjust balloon inflation for correct and incorrect answers", ->
  game = new Pop.Game()
  round = new Pop.Round({ game: game, tenses: ["Present"] })
  balloon = round.balloons[0]
  startingInflation = balloon.inflation
  round.currentInfinitive = "acostar"
  quiz = balloon.startQuiz()
  quiz.submitAnswer("acuesto")
  deepEqual(
    balloon.inflation,
    startingInflation + Pop.Config.inflationRate,
    "correct answers inflate the balloon"
  )
  quiz.submitAnswer("incorrect answer")
  deepEqual(
    balloon.inflation,
    startingInflation + Pop.Config.inflationRate - Pop.Config.deflationRate,
    "wrong answers deflate the balloon"
  )
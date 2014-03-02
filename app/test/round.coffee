module "Round Tests"

test "rounds have a set of selected tenses", ->
  round = game.startRound({ tenses: ["past", "present"] })
  deepEqual(round.tenses, ["past", "present"], "returns the round's tenses")

test "rounds have a currentQuiz", ->
  round = game.startRound({ tenses: ["past", "present"] })
  quiz = round.balloons[0].startQuiz()
  deepEqual(round.currentQuiz, quiz, "returns the round's current quiz")

test "rounds have an adjustable number of balloons", ->
  round = game.startRound({ tenses: ["past", "present"], balloons: 20 })
  deepEqual(round.balloons.length, 20, "adjustable balloon count")
  round = game.startRound({ tenses: ["past", "present"] })
  deepEqual(round.balloons.length, 30, "balloon count defaults to 30")
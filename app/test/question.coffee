module "Question Tests"

test "questions have an answer and a conjugation", ->
  game = new Pop.Game()
  question = new Pop.Question({ game: game, key: "2s", value: "acuestas" })
  deepEqual(question.conjugation, "tu", "returns conjugation")
  deepEqual(question.answer, "acuestas", "returns the correct answer")

test "checkAnswer determines if an answer to a question is correct", ->
  game = new Pop.Game()
  question = new Pop.Question({ game: game, key: "2s", value: "acuestas" })
  ok(question.checkAnswer("acuestas"), "checkAnswer returns true if correct")
  ok(!question.checkAnswer("I wrong"), "checkAnswer returns false if incorrect")
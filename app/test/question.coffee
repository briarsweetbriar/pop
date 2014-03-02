module "Question Tests"

test "questions have an answer and a conjugation", ->
  question = new Question({ key: "fps", value: "I err" })
  deepEqual(question.conjugation, "First Person Singular", "returns conjugation")
  deepEqual(question.answer, "I err", "returns the correct answer")

test "checkAnswer determines if an answer to a question is correct", ->
  question = new Question({ key: "fps", value: "I err" })
  ok(question.checkAnswer("I err"), "checkAnswer returns true if correct")
  ok(!question.checkAnswer("I wrong"), "checkAnswer returns false if incorrect")
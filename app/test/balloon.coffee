module "Balloon Tests"

test "balloons' inflation score defaults to between 35 and 65", ->
  balloon = new Balloon({ tense: "present" })
  ok(balloon.inflation <= 65 && balloon.inflation >= 35,
    "balloon inflation varies by default")

test "balloons can prompt a new quiz based on their tense", ->
  round = game.startRound({ tenses: ["past", "present"] })
  balloon = new Balloon({ tense: "present" })
  quiz = balloon.startQuiz()
  deepEqual(game.currentRound.currentQuiz, quiz, "ballons start new quiz")

test "balloons pop if they reach 100 inflation", ->
  game.startRound({ tenses: ["past", "present"] })
  game.currentRound.currentInfinitive = "to err"
  balloon = new Balloon({ tense: "present", inflation: 50 })
  balloon.inflation = 100
  equal(game.currentRound.balloons.indexOf(balloon), -1,
    "the balloon is removed from the round's balloon array")
  equal(game.currentRound.pops, 1, "rounds keep track of pops")

test "balloons drop if they reach 100 inflation", ->
  game.startRound({ tenses: ["past", "present"] })
  game.currentRound.currentInfinitive = "to err"
  balloon = new Balloon({ tense: "present", inflation: 50 })
  balloon.inflation = 0
  equal(game.currentRound.balloons.indexOf(balloon), -1,
    "the balloon is removed from the round's balloon array")
  equal(game.currentRound.drops, 1, "rounds keep track of drops")
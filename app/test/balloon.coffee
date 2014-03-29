module "Balloon Tests"

test "Balloon has properties", ->
  round = new Pop.Round({ tenses: ["Present"], game: new Pop.Game() })
  balloon = new Pop.Balloon({ round: round, tense: "Present" })
  equal(balloon.tense, "Present", "tense")
  ok(balloon.inflation >= 35 && balloon.inflation <= 65, "inflation")
  ok(balloon.round instanceof Pop.Round, "round")

test "balloons pop if they reach 100 inflation", ->
  round = new Pop.Round({ tenses: ["Present"], game: new Pop.Game() })
  balloon = round.balloons[0]
  balloon.inflation = 100
  equal(round.balloons.indexOf(balloon), -1,
    "the balloon is removed from the round's balloon array")
  equal(round.scoreKeeper.pops, 1, "rounds keep track of pops")
  equal(round.scoreKeeper.presentPops, 1, "rounds keep track of tense pops")

test "balloons drop if they reach 0 inflation", ->
  round = new Pop.Round({ tenses: ["Present"], game: new Pop.Game() })
  balloon = round.balloons[0]
  balloon.inflation = 0
  equal(round.balloons.indexOf(balloon), -1,
    "the balloon is removed from the round's balloon array")
  equal(round.scoreKeeper.drops, 1, "rounds keep track of drops")
  equal(round.scoreKeeper.presentDrops, 1, "rounds keep track of tense drops")
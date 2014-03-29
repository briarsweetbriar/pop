module "RoundManager Tests"

test "RoundManager has properties", ->
  roundManager = new Pop.RoundManager({ game: new Pop.Game() })
  equal(roundManager.currentRound, null, "currentRound")
  ok(roundManager.game instanceof Pop.Game, "game")

test "can initiate new Rounds", ->
  game = new Pop.Game()
  roundManager = game.roundManager
  roundTenses = ["Tense 1", "Tense 2"]
  ok(roundManager.newRound({ tenses: roundTenses }) instanceof Pop.Round,
    "and returns the new round")
  ok(roundManager.currentRound instanceof Pop.Round,
    "and sets currentRound")
  deepEqual(roundManager.currentRound.tenses, roundTenses,
    "accepts an array of tenses")
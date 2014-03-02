module "Game Tests"

test "games have a currentRound", ->
  round = game.startRound({ tenses: ["past", "present"] })
  deepEqual(game.currentRound, round, "returns the game's current round")
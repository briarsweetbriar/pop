module "Round Tests"

test "Round has properties", ->
  roundTenses = ["Tense 1", "Tense 2"]
  round = new Pop.Round({ tenses: roundTenses, game: new Pop.Game() })
  deepEqual(round.tenses, roundTenses, "tenses")
  ok(round.game instanceof Pop.Game, "game")
  ok(round.scoreKeeper instanceof Pop.ScoreKeeper, "scoreKeeper")

test "Round has balloons", ->
  game = new Pop.Game()
  balloonCount = 42
  manualRound = new Pop.Round({ tenses: ["Present"], balloons: balloonCount, game: game })
  defaultRound = new Pop.Round({ tenses: ["Present"], game: game })
  deepEqual(manualRound.balloons.length, balloonCount,
    "whose amount can be specified")
  deepEqual(defaultRound.balloons.length, Pop.Config.defaultBalloonCount,
    "whose amount defaults to #{ Pop.Config.defaultBalloonCount }")
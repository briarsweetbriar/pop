module "Game Tests"

test "Game has object properties", ->
  game = new Pop.Game()
  ok(game.languageManager instanceof Pop.LanguageManager, "languageManager")
  ok(game.scoreKeeper instanceof Pop.ScoreKeeper, "scoreKeeper")
  ok(game.roundManager instanceof Pop.RoundManager, "RoundManager")

test "Game's scoreKeeper is set to the default language", ->
  game = new Pop.Game()
  equal(game.scoreKeeper.futurePops, 0, "and has tense-specific pops")
  equal(game.scoreKeeper.subjunctivePresentDrops, 0, "and drops")
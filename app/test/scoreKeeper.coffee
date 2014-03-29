module "ScoreKeeper Tests"

test "ScoreKeeper has properties", ->
  scoreKeeper = new Pop.ScoreKeeper
  equal(scoreKeeper.pops, 0, "pops")
  equal(scoreKeeper.drops, 0, "drops")

test "ScoreKeeper has dynamic properties", ->
  scoreKeeper = new Pop.ScoreKeeper ["Present", "Future Subjunctive"]
  equal(scoreKeeper.presentPops, 0, "tense-specific pops")
  equal(scoreKeeper.futureSubjunctiveDrops, 0, "tense-specific drops")
Pop.ScoreKeeper = (tenses = []) ->
  @pops = 0
  @drops = 0
  @points = 0
  @rounds = 0

  for tense in tenses
    @["#{tense.camelize()}Pops"] = 0
    @["#{tense.camelize()}Drops"] = 0

  return
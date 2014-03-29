Pop.Language = (params) ->
  @name = params.name
  @tenses = params.tenses
  @conjugations = params.conjugations
  @verbs = params.verbs

  @findVerbByInfinitive = (infinitive) =>
    for verb in @verbs
      return verb if verb.infinitive == infinitive

  @findConjugation = (key) =>
    for conjugation in @conjugations
      return conjugation.value if conjugation.key == key

  return

Pop.Language.prototype.colorForTense = (tense) ->
  tenseIndex = @tenses.indexOf(tense)
  switch tenseIndex
    when 0 then return "#04756F"
    when 1 then return "#FF8C00"
    when 2 then return "#D90000"
    when 3 then return "#002D00"
    when 4 then return "#2E0927"
    when 5 then return "#FF8CFF"
    when 6 then return "#FF8"
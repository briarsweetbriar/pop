Language = (params) ->
  this.name = params.name
  this.tenses = params.tenses
  this.verbs = params.verbs
  this.conjugations = params.conjugations

  this.findVerbByInfinitive = (infinitive) =>
    for verb in this.verbs
      return verb if verb.infinitive == infinitive

  this.findConjugation = (key) =>
    for conjugation in this.conjugations
      return conjugation.value if conjugation.key == key

  return
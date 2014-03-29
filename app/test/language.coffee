module "Language Tests"

test "Language has properties", ->
  rawLanguage = Pop.languages[0]
  language = new Pop.Language rawLanguage
  deepEqual(language.name, rawLanguage.name, "name")
  deepEqual(language.tenses, rawLanguage.tenses, "tenses")
  deepEqual(language.conjugations, rawLanguage.conjugations, "conjugations")
  deepEqual(language.verbs, rawLanguage.verbs, "verbs")

test "Language has finder methods", ->
  rawLanguage = Pop.languages[0]
  language = new Pop.Language rawLanguage
  equal(language.findVerbByInfinitive("encontrar").infinitive, "encontrar",
    "for verbs by infinitive")
  equal(language.findConjugation("2s"), "tu", "for conjugations by key")

test "Language generates colors for its tenses", ->
  rawLanguage = Pop.languages[0]
  language = new Pop.Language rawLanguage
  equal(language.colorForTense("Present"), "#04756F", "in hex")
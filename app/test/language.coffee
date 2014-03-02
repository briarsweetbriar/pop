module "Language Tests"

test "returns a list of languages", ->
  languageNames = []
  languageNames.push language.name for language in game.languages
  deepEqual(languageNames, ["Test 1", "Test 2"], "returns language names")

test "returns a list of tenses", ->
  languageTenses = []
  languageTenses.push tense for tense in game.languages[0].tenses
  deepEqual(languageTenses, ["past", "present", "future"], "returns tenses")

test "returns a list of verbs", ->
  languageVerbs = []
  languageVerbs.push verb.infinitive for verb in game.languages[0].verbs
  deepEqual(languageVerbs, ["to test", "to err"], "returns verbs")

test "returns a list of conjugations", ->
  languageConjugations = []
  for conj in game.languages[0].conjugations
    languageConjugations.push conj.value
  deepEqual(languageConjugations, ["First Person Singular",
    "Second Person Singular", "Third Person Singular", "First Person Plural",
    "Second Person Plural", "Third Person Plural"], "returns conjugations")
module "Main Tests"

test "sets the game's languages", ->
  languageNames = []
  languageNames.push language.name for language in game.languages
  deepEqual(languageNames, ["Test 1", "Test 2"], "sets language names")

test "sets the game's default language to the first", ->
  deepEqual(game.currentLanguage.name, "Test 1", "sets default language")
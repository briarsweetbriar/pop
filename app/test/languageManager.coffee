module "LanguageManager Tests"

test "LanguageManager has properties", ->
  rawLanguage = Pop.languages[0]
  languageManager = new Pop.LanguageManager [rawLanguage]
  deepEqual(languageManager.languages[0].name, rawLanguage.name, "languages")
  deepEqual(languageManager.currentLanguage.name, rawLanguage.name,
    "currentLanguages")
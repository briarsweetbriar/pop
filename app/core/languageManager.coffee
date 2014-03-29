Pop.LanguageManager = (rawLanguages) ->
  @languages = []
  @currentLanguage = null

  for language in rawLanguages
    @languages.push new Pop.Language language
    @currentLanguage = @languages[0]

  return
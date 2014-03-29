Pop.Game = (params) ->
  @languageManager = new Pop.LanguageManager(Pop.languages)
  @scoreKeeper = new Pop.ScoreKeeper(@currentLanguage().tenses)
  @roundManager = new Pop.RoundManager({ game: this })

  return

Pop.Game.prototype.currentLanguage = ->
  @languageManager.currentLanguage
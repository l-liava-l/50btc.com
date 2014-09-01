App.factory 'media', () ->

  {

    play: -> this.$$sound.play()
    stop: -> this.$$sound.stop()

    $$sound: new Media('file:///android_asset/www/sound/sound.mp3', null, null, this.status)
  }

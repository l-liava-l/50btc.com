App.controller 'AlertCtrl',  ($scope, core, media, $location) ->


  $scope.status = core.model.status

  #===== alert repeat
  if core.model.settings.sound
    mediaIntervalId = setInterval(-> media.play '', 45000); media.play()

  #===== handlers
  $scope.stopMedia = ->
    clearInterval(mediaIntervalId); media.stop()

  $scope.cancel = ->
    $scope.stopMedia()
    $scope.status.hardwareAlertPrevent = true
    $location.path('/home')




App.controller 'SettingsCtrl',  ($scope, core) ->

  $scope.settings = core.model.settings ?= {
    refresh: 5
    sound: true
    alert: null
    apiKey: null
  }

  $scope.status = core.model.status

  $scope.save = ->
    core.save('settings',  $scope.settings)
    window.location.reload('/home')


  $scope.reload = ->
    core.loadFromLocal('settings')

  $scope.p = ->
    console.log 'paste'
    cordova.plugins.clipboard.paste (text) ->
      $scope.settings.apiKey = text


  if !core.model.status.running then core.init()





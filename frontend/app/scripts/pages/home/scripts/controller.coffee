App.controller 'HomeCtrl',  ($scope, $location, core) ->

  $scope.location = (path)->
    $location.path(path)

  $scope.status = core.model.status

  if !core.model.status.running then core.init()

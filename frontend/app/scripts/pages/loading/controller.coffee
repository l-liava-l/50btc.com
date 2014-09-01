App.controller 'LoadingCtrl',  ($scope, $location, cordovaFs, core) ->

  cordovaFs.ready.then ->
      $location.path('/settings')



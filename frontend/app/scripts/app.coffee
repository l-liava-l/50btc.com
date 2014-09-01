'use strict'
App = angular.module('app', ['ionic', 'ngResource']).run () ->

  App.config [
    '$stateProvider'
    '$urlRouterProvider'
    '$httpProvider'
    ($stateProvider, $urlRouterProvider, $httpProvider) ->

      headers  = $httpProvider.defaults.headers
      headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'

      $httpProvider.defaults.transformRequest.unshift (params) ->

        type = params?.type
        data = params?.data

        if type is 'json' then return data
        if angular.isObject(data) then angular.toQueryString(data) else data

      $stateProvider
      .state 'home',
        url: '/home'
        abstract: false
        templateUrl: "templates/pages/home/home.html"
        controller: "HomeCtrl"


      .state 'settings',
          url: '/settings'
          abstract: false
          templateUrl: "templates/pages/settings/settings.html"
          controller: "SettingsCtrl"

      .state 'loading',
        url: '/loading'
        abstract: false
        templateUrl: "templates/pages/loading/loading.html"
        controller: "LoadingCtrl"

      .state 'alert',
        url: '/alert'
        abstract: false
        templateUrl: "templates/pages/alert/page.html"
        controller: "AlertCtrl"


      $urlRouterProvider.otherwise "loading"


  ]


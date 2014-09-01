App.factory 'server', ['$resource', ($resource) ->

  api = (params) ->
    $resource('' + params.url, {
    }, {
      get:
        method: 'GET'
    }, {
      stripTrailingSlashes: false
    })

  return api
]


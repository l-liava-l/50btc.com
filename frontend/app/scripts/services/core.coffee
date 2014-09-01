App.factory 'core', [
  'storage'
  'server'
  '$location'
  (storage, server, $location) ->

    storage.session.status ?= {}
    storage.session.settings ?= {}

    core = {
      model: storage.session

      save : (key, value) ->
        storage.saveToLocal(key, value)

      $$getData: (onSuccess) ->
        server(({url: 'https://50btc.com/api/' + this.model.settings.apiKey})).get(onSuccess)

      loadFromLocal: (prop) ->
        storage.loadFromLocal(prop)
    }


    settings = core.model.settings
    status = core.model.status

    status.historyModel = historyModel = workers: {}

    core.init = ->
      status.running = true
      core.$$getData(onDataGot)
      connect()

    connect = ->
      core.$$getData(onDataGot)
      setTimeout(connect, settings.refresh * 1000)

    onDataGot = (data) ->
      if !data.error then checkData(status.data = data)
      else status.error = !data.error


    checkData = (data) ->
      checkWorkersOnline(data.workers)
      checkHashRate(data.user.hash_rate)
      if settings.alert > data.user.hash_rate and !status.hardwareAlertPrevent
        $location.path('/alert')


    checkHashRate = (hashRate)->
      historyModel.rate ?= status.hashRate = hashRate

      if historyModel.rate < hashRate then historyModel.powerStatus = 2
      else if historyModel.rate is hashRate then historyModel.powerStatus = 1
      else historyModel.powerStatus = 0


    checkWorkersOnline = (workers)->
      status.badWorkers = []

      for workerId of workers
        model = historyModel.workers

        if !model[workerId] then model[workerId] = {
          last: workers[workerId].last_share
          status: 1
        }
        else
          if model[workerId].last isnt workers[workerId].last_share
            model[workerId].last = workers[workerId].last_share
            model[workerId].status = 2
          else
            if model[workerId].status > 0 then model[workerId].status--
            if model[workerId].status <= 0 then status.badWorkers.push workers[workerId].worker_name


    return core
]

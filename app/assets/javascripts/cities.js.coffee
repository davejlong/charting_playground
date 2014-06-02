#= require d3/d3
#= require topojson/topojson

class SeeClickFixVisualizer
  constructor: (el) ->
    @city = d3.select(el).attr('data-city')

    @getData(@dataRenderer)

  getData: (callback) ->
    d3.json("/cities/#{@city}")
      .get (error, data) ->
        if error then utilities.showMessage('error', error)
        else callback(data)

  dataRenderer: (data) ->
    new DataMapper('#map', data)

class DataMapper
  constructor: (@container, @data) ->



handlers.register 'SeeClickFixVisualizer', SeeClickFixVisualizer

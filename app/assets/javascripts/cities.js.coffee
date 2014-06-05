#= require d3/d3
#= require leaflet/dist/leaflet.js

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
    new DataRenderer(data.issues, 'map').draw()

class DataRenderer
  constructor: (@data, @container) ->
  draw: ->
    centerPoint = [
      d3.median @data, (d) -> d.lat
      d3.median @data, (d) -> d.lng
    ]

    console.log centerPoint.toString()
    @map = L.map(@container).setView centerPoint, 13
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo @map

    @data.forEach (d) =>
      # console.log(d)
      marker = L.marker([d.lat, d.lng]).addTo(@map)
        .bindPopup(d.description)
        #.clickable()
      #marker.on 'click', marker.togglePopup

    popup = L.popup()
    @map.on 'click', (e) =>
      popup.setLatLng e.latlng
        .setContent "You clicked on the map at #{e.latlng.toString()}"
        .openOn @map

handlers.register 'SeeClickFixVisualizer', SeeClickFixVisualizer

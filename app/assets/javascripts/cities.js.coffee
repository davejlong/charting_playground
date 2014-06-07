#= require d3
#= require leaflet

L.Icon.Default.imagePath = "/assets/leaflet"

class SeeClickFixVisualizer
  constructor: (el) ->
    @lat = d3.select(el).attr('data-lat')
    @lng = d3.select(el).attr('data-lng')

    @getData(@dataRenderer)

  getData: (callback) ->
    url = "/cities"
    url += "/#{@lat}/#{@lng}" if @lat && @lng
    d3.json("#{url}.json")
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
    latExtent = d3.extent @data, (d) -> d.lat
    lngExtent = d3.extent @data, (d) -> d.lng

    @map = L.map(@container)
    @map.on 'click', (e) ->
      console.log "Clicked at #{e.latlng.toString()}"

    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo @map

    @map.fitBounds([
      [ latExtent[0], lngExtent[0] ]
      [ latExtent[1], lngExtent[1] ]
    ])

    @data.forEach (d) =>
      marker = L.marker([d.lat, d.lng]).addTo(@map)
        .bindPopup("<strong>#{d.status}</strong><br />#{d.address}<hr />#{d.description}")

    @clusterPoints()

handlers.register 'SeeClickFixVisualizer', SeeClickFixVisualizer

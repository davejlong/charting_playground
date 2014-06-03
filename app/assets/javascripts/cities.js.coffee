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
    new DataMapper('#map', data).draw()

class DataMapper
  margin: { top: 20, right: 20, bottom: 30, left: 40 }
  width: 960
  height: 300

  constructor: (container, data) ->
    @data = data.issues

    @container = d3.select container

    width = @container.style('width').match /^\d+/
    @width = +width[0] if width.length
    @width = @width - @margin.left - @margin.right
    @height = @height - @margin.top - @margin.bottom

  draw: ->
    @container = @container
      .append 'svg'
      .attr 'width', @width + @margin.left + @margin.right
      .attr 'height', @height + @margin.top + @margin.bottom
      .append 'g'
      .attr 'transform', "translate(#{@margin.left}, #{@margin.top})"
    @drawAxes()
    @drawDots()

  drawAxes: ->
    @container.append 'g'
      .attr('class', 'x axis').attr('transform', "translate(0, #{@height})")
      .call(@xAxis())
      .append('text').attr('class', 'label').attr('x', @width).attr('y', -6)
      .style('text-anchor', 'end').text('Latitude')
    @container.append 'g'
      .attr('class', 'y axis').call(@yAxis())
      .append('text').attr('class', 'label').attr('transform', 'rotate(-90)')
      .attr('y', 6).attr('dy', '.71em').style('text-anchor', 'end')
      .text('Longitude')

  drawDots: ->
    @container.selectAll('.dot').data(@data).enter()
      .append 'circle'
      .attr 'class', 'dot'
      .attr 'r', 6
      .attr 'cx', (d) => @x()(d.lat)
      .attr 'cy', (d) => @y()(d.lng)
      .style 'fill', 'green'

  x: ->
    @_x ?= d3.scale.linear()
      .range [0, @width]
      .domain d3.extent(@data, (d) -> d.lat)
      .nice()
  y: ->
    @_y ?= d3.scale.linear()
      .range [@height, 0]
      .domain d3.extent(@data, (d) -> d.lng)
      .nice()

  xAxis: -> @_xAxis ?= d3.svg.axis().scale(@x()).orient 'bottom'
  yAxis: -> @_yAxis ?= d3.svg.axis().scale(@y()).orient 'left'

handlers.register 'SeeClickFixVisualizer', SeeClickFixVisualizer

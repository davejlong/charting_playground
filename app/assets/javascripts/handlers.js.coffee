class Handlers
  handlers: null

  constructor: ->
    @handlers = {}

  register: (name, object) ->
    @handlers[name] = object

  run: ->
    handlers = document.querySelectorAll('[data-handler]')
    return unless handlers.length
    for element in handlers
      handler = element.getAttribute('data-handler')
      if handler of @handlers then new @handlers[handler](element)

window.handlers = new Handlers()
$(document).on 'page:change', ( -> handlers.run() )

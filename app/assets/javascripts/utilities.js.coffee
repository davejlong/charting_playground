window.utilities = {
  showMessage: (type, message) ->
    body = d3.select('main')
    body.selectAll('.alert-box').remove()
    div = body.insert('div', ':first-child')
      .attr('class', "alert-box #{type}")
    div.append('span').text(message)
}

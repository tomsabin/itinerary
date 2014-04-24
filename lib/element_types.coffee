@DividerElement = (doc) ->
  finalElement: -> '<hr>'

@TextElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    "<p contentEditable=true data-element-id='#{doc._id}'>#{doc.body}</p>"
  finalElement: ->
    "<p>#{doc.body}</p>"

@LinkElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    "<p contentEditable=true data-element-id='#{doc._id}'>#{doc.body}</p>"
  finalElement: ->
    "<a href='#{doc.body}'>#{doc.body}</a>"

@PhotoElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    "<p contentEditable=true data-element-id='#{doc._id}'>#{doc.body}</p>"
  finalElement: ->
    "<img src='#{doc.body}' />"

@MapElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    "<p contentEditable=true data-element-id='#{doc._id}'>#{doc.body}</p>"
  finalElement: ->
    "Map for: #{doc.body}"

@DateElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    "<p contentEditable=true data-element-id='#{doc._id}'>#{doc.body}</p>"
  finalElement: ->
    "Parsed date for: #{doc.body}"

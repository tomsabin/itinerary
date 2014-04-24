wrap = (doc, el) ->
  """
<div data-element-id='#{doc._id}'>
  #{el}
  <input data-action='removeElement' type='button' value='delete' />
</div>
  """

@DividerElement = (doc) ->
  finalElement: -> wrap doc, '<hr>'

@TextElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    wrap doc, "<p contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "<p>#{doc.body}</p>"

@LinkElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    wrap doc, "<p contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "<a href='#{doc.body}'>#{doc.body}</a>"

@PhotoElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    wrap doc, "<p contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "<img src='#{doc.body}' />"

@MapElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    wrap doc, "<p contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "Map for: #{doc.body}"

@DateElement = (doc) ->
  editable: -> doc.editable
  initalElement: ->
    wrap doc, "<p contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "Parsed date for: #{doc.body}"

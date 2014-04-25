wrap = (doc, el) ->
  """
<div class='item' data-element-id='#{doc._id}'>
  #{el}
  <input class='remove-item' data-action='removeElement' type='button' value='delete' />
  <div class='handle'>handle</div>
</div>
  """

@DividerElement = (doc) ->
  finalElement: -> wrap doc, '<hr>'
  position: -> doc.position

@TextElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<p class='editable editable-p' contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "<p class='item-p'>#{doc.body}</p>"

@LinkElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<p class='editable editable-a' contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "<a class='item-a' href='#{doc.body}'>#{doc.body}</a>"

@PhotoElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<p class='editable editable-img' contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "<img class='item-img' src='#{doc.body}' />"

@MapElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<p class='editable editable-map' contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "??? Map for: #{doc.body}"

@DateElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<p class='editable editable-date' contentEditable=true>#{doc.body}</p>"
  finalElement: ->
    wrap doc, "??? Parsed date for: #{doc.body}"

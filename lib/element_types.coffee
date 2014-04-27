wrap = (doc, el) ->
  """
<div class='item item-#{doc.type}'>
  <i id='removeElement' class='fa fa-times remove-item'></i>
  <div class='item-content-container'>
    <div class='item-content' data-element-id='#{doc._id}' data-body='#{doc.body}'>#{el}</div>
    <i class='fa fa-sort handle'></i>
  </div>
</div>
  """

@DividerElement = (doc) ->
  finalElement: -> wrap doc, ''
  position: -> doc.position

@TextElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input class='editable editable-p' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<p class='item-p' contentEditable=true>#{doc.body}</p>"

@LinkElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input class='editable editable-a' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<a class='item-a' href='#{doc.body}'>#{doc.body}</a>"

@PhotoElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input class='editable editable-img' placeholder='#{doc.body}'></input>"
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

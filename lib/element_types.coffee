# DRY up editable function somehow
wrap = (doc, el) ->
  """
<div data-element-id='#{doc._id}' class='item item-#{doc.type}'>
  <i data-action='removeElement' class='fa fa-times remove-item'></i>
  <div class='item-content-container' data-body='#{doc.body}'>
    #{el}
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
    wrap doc, "<input class='item-entry' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<p class='item-p editable' contentEditable=true>#{doc.body}</p>"

@LinkElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input class='item-entry' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<a class='item-a' href='#{doc.body}'>#{doc.body}</a>"

@PhotoElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input class='item-entry' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<img class='item-img' src='#{doc.body}' />"

@MapElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input class='item-entry' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "??? Map for: #{doc.body}"

@DateElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input class='item-entry' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "??? Parsed date for: #{doc.body}"

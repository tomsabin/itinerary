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
    wrap doc, "<input type='text' class='item-entry' data-item-type='#{doc.type}' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<p class='item-text editable' contentEditable=true>#{doc.body}</p>"

@LinkElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input type='url' class='item-entry' data-item-type='#{doc.type}' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<a class='item-link' href='#{doc.body}'>#{doc.second_body}</a>"

@PhotoElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input type='text' class='item-entry' data-item-type='#{doc.type}' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<img class='item-photo' src='#{doc.body}' />"

@MapElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input type='text' class='item-entry' data-item-type='#{doc.type}' placeholder='#{doc.body}'></input>"
  finalElement: ->
    googleMapUrl = "http://maps.google.com/?q=#{doc.body}"
    staticGoogleMap = "http://maps.googleapis.com/maps/api/staticmap?center=#{doc.body}&markers=color:red|#{doc.body}&zoom=13&size=492x320&sensor=false"
    wrap doc, "<a href='#{googleMapUrl}'><img class='item-map' src='#{staticGoogleMap}' /></a><div class='item-map-text'>#{doc.body}</div>"

@DateElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    wrap doc, "<input type='date' class='item-entry' data-item-type='#{doc.type}' placeholder='#{doc.body}'></input>"
  finalElement: ->
    wrap doc, "<p class='item-date editable' contentEditable=true>#{doc.body}</p>"

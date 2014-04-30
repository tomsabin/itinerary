openContainer = ->
  $('#openElementButtonContainer').hide()
  $('#elementButtonContainer').show()
closeContainer = ->
  $('#openElementButtonContainer').show()
  $('#elementButtonContainer').hide()

Template.addElements.events
  'click #openElementButtonContainer': ->
    openContainer()

  'click [data-action="addElement"]': (e) ->
    if @itinerary?
      elementId = createElement
        type: e.target.getAttribute('data-element-type')
        parentId: @itinerary._id
      $("div[data-element-id='#{elementId}'] input").focus()
      closeContainer()

Template.addElements.rendered = ->
  $('#window').click ->
    closeContainer()
  $('#elementButtonContainer').hide()

openContainer = ->
  $('#openElementButtonContainer').hide()
  $('#elementButtonContainer').show()
closeContainers = ->
  $('#openElementButtonContainer').show()
  $('#dateTimeElementsContainer').hide()
  $('#elementButtonContainer').hide()
openDateTimeElementsContainer = ->
  $('#openElementButtonContainer').hide()
  $('#dateTimeElementsContainer').show()
  $('#elementButtonContainer').hide()

Template.addElements.events
  'click #openElementButtonContainer': ->
    openContainer()

  'click #openDateTimeElementsContainer': ->
    openDateTimeElementsContainer()

  'click [data-action="addElement"]': (e) ->
    if @itinerary?
      elementId = createElement
        type: e.target.getAttribute('data-element-type')
        parentId: @itinerary._id
      $("div[data-element-id='#{elementId}'] input").focus()
      closeContainers()

Template.addElements.rendered = ->
  $('#window').click ->
    closeContainers()
  $('#dateTimeElementsContainer').hide()
  $('#elementButtonContainer').hide()

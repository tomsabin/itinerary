Template.addElement.events
  'click #openElementButtonContainer': ->
    openElementsContainer()

  'click #openDateTimeElementsContainer': ->
    openDateTimeElementsContainer()

  'click [data-action="addElement"]': (e) ->
    if @itinerary?
      elementId = createElement
        type: e.target.getAttribute('data-element-type')
        parentId: @itinerary._id
      $("div[data-element-id='#{elementId}'] input").focus()
      showOpeners()

Template.addElement.events
  'click #openElementButtonContainer': -> openElementsContainer()
  'click #openDateTimeElementsContainer': -> openDateTimeElementsContainer()
  'click [data-action="addElement"]': (e) ->
    if @itinerary?
      parentId = @itinerary._id
      belongsTo = 'itinerary'
    if @card?
      parentId = @card._id
      belongsTo = 'card'
    if parentId? and belongsTo?
      elementId = Elements.insert
        type: e.target.getAttribute('data-element-type')
        belongs_to: belongsTo
        parent_id: parentId
      $("div[data-element-id='#{elementId}'] input").focus()
      showOpeners()

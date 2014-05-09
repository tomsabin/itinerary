Template.addElement.events
  'click #openElementButtonContainer': -> openElementsContainer()
  'click #openDateTimeElementsContainer': -> openDateTimeElementsContainer()
  'click [data-action="addElement"]': (e) ->
    belongsTo = 'itinerary' if @document_type is 'itinerary'
    belongsTo = 'card' if @document_type is 'card'
    if belongsTo?
      elementId = Elements.insert
        type: e.target.getAttribute('data-element-type')
        belongs_to: belongsTo
        parent_id: @_id
      $("div[data-element-id='#{elementId}'] input").focus()
      showOpeners()

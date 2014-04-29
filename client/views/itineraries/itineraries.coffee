Template.itineraryButtons.events
  'click #openElementButtonContainer': ->
    $('#openElementButtonContainer').hide()
    $('#elementButtonContainer').show()

  'click #clearItinerary': ->
    if @itinerary?
      if confirm('Are you sure you want to reset all data?')
        Meteor.call('clearItineraryElements', @itinerary._id)
        Itineraries.update { _id: @itinerary._id }, { $set: DefaultItinerariesValues() }

  'click #deleteItinerary': ->
    if @itinerary?
      if confirm('Are you sure you want to delete?')
        Meteor.call('clearItineraryElements', @itinerary._id)
        Itineraries.remove @itinerary._id
        Router.go('/')

  'click [data-action="addElement"]': (e) ->
    if @itinerary?
      elementId = createElement
        type: e.target.getAttribute('data-element-type')
        parentId: @itinerary._id
      $("div[data-element-id='#{elementId}'] input").focus()
      $('#openElementButtonContainer').show()
      $('#elementButtonContainer').hide()

Template.itineraryButtons.rendered = ->
  # $('#window').click ->
  #   $('#openElementButtonContainer').show()
  #   $('#elementButtonContainer').hide()
  $('#elementButtonContainer').hide()

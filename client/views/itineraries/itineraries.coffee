@updateItineraryHeader = (e, that) ->
  if e.target.id is 'itineraryTitle'
    Itineraries.update { _id: that.itinerary._id }, { $set: title: e.target.innerText }
  else if e.target.id is 'itineraryDescription'
    Itineraries.update { _id: that.itinerary._id }, { $set: description: e.target.innerText }

Template.itineraryHeader.events
  focusout: (e) ->
    updateItineraryHeader(e, this)

  keypress: (e) ->
    if e.which is 13
      updateItineraryHeader(e, this)

Template.itineraryButtons.events
  'click #openElementButtonContainer': ->
    $('#openElementButtonContainer').hide()
    $('#elementButtonContainer').show()

  'click #clearItinerary': ->
    if confirm('Are you sure you want to reset all data?')
      Meteor.call('clearItineraryElements', @itinerary._id)
      Itineraries.update { _id: @itinerary._id }, { $set: DefaultItinerariesValues() }

  'click #deleteItinerary': ->
    if confirm('Are you sure you want to delete?')
      Meteor.call('clearItineraryElements', @itinerary._id)
      Itineraries.remove @itinerary._id
      Router.go('/')

  'click [data-action="addElement"]': (e) ->
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

openContainer = ->
  $('#openElementButtonContainer').hide()
  $('#elementButtonContainer').show()
closeContainer = ->
  $('#openElementButtonContainer').show()
  $('#elementButtonContainer').hide()

Template.itineraryButtons.events
  'click #openElementButtonContainer': ->
    openContainer()

  'click #clearItinerary': ->
    if @itinerary?
      if confirm('Are you sure you want to reset all data?')
        Meteor.call('resetItineraryElements', @itinerary._id)

  'click #deleteItinerary': ->
    if @itinerary?
      if confirm('Are you sure you want to delete?')
        Meteor.call('removeItineraryElements', @itinerary._id)
        Itineraries.remove @itinerary._id
        Router.go('/')

  'click [data-action="addElement"]': (e) ->
    if @itinerary?
      elementId = createElement
        type: e.target.getAttribute('data-element-type')
        parentId: @itinerary._id
      $("div[data-element-id='#{elementId}'] input").focus()
      closeContainer()

Template.itineraryButtons.rendered = ->
  $('#window').click ->
    closeContainer()
  $('#elementButtonContainer').hide()

Template.itineraryButtons.events
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

Template.itinerary.rendered = ->
  $('#window').click ->
    showOpeners()
  hideContainers()

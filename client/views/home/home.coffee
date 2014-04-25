Template.home.events
  'click #newItinerary': ->
    itineraryId = createItinerary()
    Router.go('itinerary', _id: itineraryId)

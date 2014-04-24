Meteor.publish 'itineraries', -> Itineraries.find()

Meteor.publish 'singleItinerary', (id) ->
  id and Itineraries.find(id)

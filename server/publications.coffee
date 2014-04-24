Meteor.publish 'elements', (parentId) ->
  parentId and Elements.find(parentId: parentId)

Meteor.publish 'itineraries', -> Itineraries.find()

Meteor.publish 'singleItinerary', (id) ->
  id and Itineraries.find(id)

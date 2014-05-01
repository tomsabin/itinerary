Meteor.publish 'card', (id) -> id and Cards.find(id)
Meteor.publish 'itinerary', (id) -> id and Itineraries.find(id)
Meteor.publish 'elements', (parentId) ->
  parentId and Elements.find(parentId: parentId)
Meteor.publish 'itineraries', -> Itineraries.find()
Meteor.publish 'headerElements', ->
  Elements.find(headerElement: { $exists: true })

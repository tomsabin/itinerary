Meteor.publish 'itineraries', -> Itineraries.find()
Meteor.publish 'headerElements', -> Elements.find(headerElement: { $exists: true })

Meteor.publish 'siblingElement', (id) -> id and Elements.find(body: id, type: 'card')
Meteor.publish 'itinerary', (id) -> id and Itineraries.find(id)
Meteor.publish 'elements', (id) -> id and Elements.find(parentId: id)
Meteor.publish 'card', (id) -> id and Cards.find(id)

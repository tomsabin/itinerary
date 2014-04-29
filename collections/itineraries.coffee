@Itineraries = new Meteor.Collection('itineraries')

@Itineraries.before.insert (userId, doc) ->
  doc.created_on = new Date().getTime()

@createItinerary = (attributes = {}) ->
  itineraryId = Itineraries.insert attributes

  createElement
    type: 'title'
    parentId: itineraryId
    headerElement: true

  createElement
    type: 'description'
    parentId: itineraryId
    headerElement: true

  itineraryId

Meteor.methods
  resetItineraryElements: (itineraryId) ->
    Elements.remove
      parentId: itineraryId
      headerElement: { $exists: false }

    Elements.update { parentId: itineraryId, type: 'title' },
      $set:
        body: 'Itinerary title'
        editable: true

    Elements.update { parentId: itineraryId, type: 'description' },
      $set:
        body: 'A short description'
        editable: true

  removeItineraryElements: (itineraryId) ->
    Elements.remove parentId: itineraryId

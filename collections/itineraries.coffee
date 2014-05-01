@Itineraries = new Meteor.Collection('itineraries')
@Itineraries.before.insert (userId, doc) ->
  doc.created_on = new Date().getTime()

@createItinerary = ->
  console.log('createItinerary')
  id = Itineraries.insert({})
  createElement
    type: 'title'
    body: 'Itinerary title'
    parentId: id
    headerElement: true
  createElement
    type: 'description'
    parentId: id
    headerElement: true
  id

Meteor.methods
  resetItinerary: (id) ->
    console.log('resetItinerary')
    Cards.find(parentId: id).forEach (card) ->
      Elements.remove(parentId: card._id)
    Cards.remove(parentId: id)
    Elements.remove
      parentId: id
      headerElement: { $exists: false }
    Elements.update { parentId: id, type: 'title' },
      $set:
        body: 'Itinerary title'
        editable: true
    Elements.update { parentId: id, type: 'description' },
      $set:
        body: 'A short description'
        editable: true

  deleteItinerary: (id) ->
    console.log('deleteItinerary')
    Cards.find(parentId: id).forEach (card) ->
      Elements.remove(parentId: card._id)
    Cards.remove(parentId: id)
    Elements.remove(parentId: id)
    Itineraries.remove(id)

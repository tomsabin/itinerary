@Itineraries = new Meteor.Collection('itineraries')
@Itineraries.before.insert (userId, doc) ->
  doc.created_on = new Date().getTime()

@createItinerary = ->
  id = Itineraries.insert({})
  createElement
    type: 'title'
    body: defaults.itinerary.title
    parentId: id
    belongsTo: 'itinerary'
    headerElement: true
  createElement
    type: 'description'
    parentId: id
    belongsTo: 'itinerary'
    headerElement: true
  id

Meteor.methods
  resetItinerary: (id) ->
    Cards.find(parentId: id).forEach (card) ->
      Elements.remove(parentId: card._id)
    Cards.remove(parentId: id)
    Elements.remove
      parentId: id
      headerElement: { $exists: false }
    Elements.update { parentId: id, type: 'title' },
      $set:
        body: defaults.itinerary.title
        editable: true
    Elements.update { parentId: id, type: 'description' },
      $set:
        body: defaults.element.description
        editable: true

  deleteItinerary: (id) ->
    Cards.find(parentId: id).forEach (card) ->
      Elements.remove(parentId: card._id)
    Cards.remove(parentId: id)
    Elements.remove(parentId: id)
    Itineraries.remove(id)

@Itineraries = new Meteor.Collection('itineraries')
@Itineraries.before.insert (userId, doc) ->
  doc.created_on = new Date().getTime()

@createItinerary = ->
  id = Itineraries.insert({})
  createHeaderElements(id, defaults.itinerary)
  id

Meteor.methods
  resetItinerary: (id) ->
    Cards.find(parentId: id).forEach (card) -> Elements.remove(parentId: card._id)
    Cards.remove(parentId: id)
    Elements.remove(parentId: id, headerElement: { $exists: false })
    resetHeaderElements(id, defaults.itinerary)

  deleteItinerary: (id) ->
    Cards.find(parentId: id).forEach (card) -> Elements.remove(parentId: card._id)
    Cards.remove(parentId: id)
    Elements.remove(parentId: id)
    Itineraries.remove(id)

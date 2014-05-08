@Itineraries = new Meteor.Collection('itineraries')

Itineraries.before.insert (userId, doc) ->
  throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless userId
  doc.user_id = userId
  doc.created_on = new Date().getTime()

Itineraries.allow
  fetch: ['user_id']
  insert: (userId, doc) -> userId and doc.user_id is userId

Itineraries.deny
  update: -> true
  remove: -> true

@createItinerary = ->
  id = Itineraries.insert({})
  createHeaderElements(id, defaults.itinerary)
  id

Meteor.methods
  resetItinerary: (id) ->
    user = Meteor.user()
    throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless user
    itinerary = Itineraries.findOne(id)
    throw new Meteor.Error(404, 'Itinerary was not found') unless itinerary
    throw new Meteor.Error(403, 'Itinerary does not belong to you') unless user._id is itinerary.user_id

    Cards.find(parent_id: id).forEach (card) -> Elements.remove(parent_id: card._id)
    Cards.remove(parent_id: id)
    Elements.remove(parent_id: id, header_element: { $exists: false })
    resetHeaderElements(id, defaults.itinerary)

  deleteItinerary: (id) ->
    user = Meteor.user()
    throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless user
    itinerary = Itineraries.findOne(id)
    throw new Meteor.Error(404, 'Itinerary was not found') unless itinerary
    throw new Meteor.Error(403, 'Itinerary does not belong to you') unless user._id is itinerary.user_id

    Cards.find(parent_id: id).forEach (card) -> Elements.remove(parent_id: card._id)
    Cards.remove(parent_id: id)
    Elements.remove(parent_id: id)
    Itineraries.remove(id)

@Itineraries = new Meteor.Collection('itineraries')

Itineraries.before.insert (userId, doc) ->
  doc.user_id = userId
  doc.created_on = new Date().getTime()

Itineraries.allow
  insert: (userId, doc) ->
    isOwner = userId and doc.user_id is userId
    hasValidAttributes = not _.difference(Object.keys(doc), defaults.itinerary.valid_insert_attributes).length
    if hasValidAttributes and isOwner
      createHeaderElements(doc._id, defaults.itinerary)
    hasValidAttributes and isOwner
  remove: (userId, doc) ->
    isOwner = userId and doc.user_id is userId
    if isOwner
      Cards.find(parent_id: doc._id).forEach (card) ->
        Elements.remove(parent_id: card._id)
      Cards.remove(parent_id: doc._id)
      Elements.remove(parent_id: doc._id)
    isOwner

Itineraries.deny
  update: -> true

Meteor.methods
  resetItinerary: (id) ->
    validateOwner('Itinerary', id, Meteor.user())
    Cards.find(parent_id: id).forEach (card) ->
      Elements.remove(parent_id: card._id)
    Cards.remove(parent_id: id)
    Elements.remove(parent_id: id, header_element: { $exists: false })
    resetHeaderElements(id, defaults.itinerary)

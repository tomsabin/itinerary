@validateOwner = (collectionName, id, user) ->
  throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless user
  switch collectionName
    when 'Itinerary' then collection = Itineraries.findOne(id)
    when 'Element' then collection = Elements.findOne(id)
    when 'Card' then collection = Cards.findOne(id)
  throw new Meteor.Error(404, "#{collectionName} was not found") unless collection
  throw new Meteor.Error(403, "#{collectionName} does not belong to you") unless user._id is collection.user_id

@validateElement = (userId, doc) ->
  throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless userId
  throw new Meteor.Error(422, 'Element type needs to be declared') unless doc.type
  throw new Meteor.Error(422, 'Element type needs to be valid') unless _.contains(defaults.element.types, doc.type)
  throw new Meteor.Error(422, 'Element needs a parent') unless doc.parent_id

@validateCard = (userId, doc) ->
  throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless userId
  throw new Meteor.Error(422, 'Card type needs to be declared') unless doc.type
  throw new Meteor.Error(422, 'Card type needs to be valid') unless _.contains(defaults.card.types, doc.type)
  throw new Meteor.Error(422, 'Card needs a parent') unless doc.parent_id

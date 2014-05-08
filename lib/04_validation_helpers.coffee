@validateElement = (userId, doc) ->
  throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless userId
  throw new Meteor.Error(422, 'Element type needs to be declared') unless doc.type
  throw new Meteor.Error(422, 'Element type needs to be valid') unless _.contains(defaults.element.types, doc.type)
  throw new Meteor.Error(422, 'Element needs a parent') unless doc.parent_id


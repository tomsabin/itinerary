@Cards = new Meteor.Collection('cards')

Cards.before.update (userId, doc) ->
  validateCard(userId, doc)

Cards.before.insert (userId, doc) ->
  validateCard(userId, doc)
  doc.user_id = userId

Cards.allow
  insert: (userId, doc) -> userId and doc.user_id is userId
  remove: (userId, doc) -> userId and doc.user_id is userId
  update: (userId, doc, fields, modifier) ->
    isOwner = userId and doc.user_id is userId
    hasValidFields = not _.difference(fields, defaults.card.valid_attributes).length
    hasValidFields and isOwner
    true

@createCard = (attributes) ->
  id = Cards.insert(attributes)
  createHeaderElements(id, defaults.card)
  elementId = Elements.insert
    type: 'card'
    body: id
    parent_id: attributes.parent_id
    card_type: attributes.type
    card_title: defaults.card.title
    card_description: defaults.element.description.body
  Cards.update { _id: id },
    $set: element_id: elementId
  id

@updateCardType = (id, type) ->
  card = Cards.findOne(id)
  throw new Meteor.Error(404, 'Card not found') unless card?
  Cards.update { _id: card._id },
    $set: type: type
  updateSiblingElement(card._id, 'type', type)

@updateSiblingElement = (id, type, body) ->
  sibling = Elements.findOne(body: id, type: 'card')
  throw new Meteor.Error(404, 'Sibling element not found') unless sibling?
  Elements.update { _id: sibling._id }, { $set: card_type: body } if type is 'type'
  Elements.update { _id: sibling._id }, { $set: card_title: body } if type is 'title'
  Elements.update { _id: sibling._id }, { $set: card_description: body } if type is 'description'

Meteor.methods
  resetCard: (id) ->
    user = Meteor.user()
    throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless user
    card = Cards.findOne(id)
    throw new Meteor.Error(404, 'Card was not found') unless card
    throw new Meteor.Error(403, 'Card does not belong to you') unless user._id is card.user_id

    Elements.remove(parent_id: id, header_element: { $exists: false })
    resetHeaderElements(id, defaults.card)
    updateSiblingElement(id, 'title', defaults.card.title)
    updateSiblingElement(id, 'description', defaults.element.description.body)

  deleteCard: (id, siblingElementId) ->
    user = Meteor.user()
    throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless user
    card = Cards.findOne(id)
    throw new Meteor.Error(404, 'Card was not found') unless card
    throw new Meteor.Error(403, 'Card does not belong to you') unless user._id is card.user_id

    Elements.remove(siblingElementId)
    Elements.remove(parent_id: id)
    Cards.remove(id)

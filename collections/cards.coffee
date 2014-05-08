@Cards = new Meteor.Collection('cards')

@createCard = (attributes) ->
  throw new Meteor.Error(422, 'Card needs a parent') unless attributes.parent_id
  throw new Meteor.Error(422, 'Card type needs to be declared') unless attributes.type
  throw new Meteor.Error(422, 'Card type needs to be valid') unless _.contains(defaults.card.types, attributes.type)
  id = Cards.insert({})
  createHeaderElements(id, defaults.card)
  attributes.element_id = createElement
    type: 'card'
    body: id
    parent_id: attributes.parent_id
    card_type: attributes.type
    card_title: defaults.card.title
    card_description: defaults.element.description.body
  Cards.update(id, attributes)
  id

@updateCardType = (id, type) ->
  throw new Meteor.Error(422, 'Card type needs to be valid') unless _.contains(defaults.card.types, type)
  card = Cards.findOne(id)
  throw new Meteor.Error(422, 'Card not found') unless card?
  card.type = type
  Cards.update(card._id, card)
  updateSiblingElement(card._id, 'type', type)

@updateSiblingElement = (id, type, body) ->
  sibling = Elements.findOne(body: id, type: 'card')
  throw new Meteor.Error(422, 'Sibling element not found') unless sibling?
  sibling.card_type = body if type is 'type'
  sibling.card_title = body if type is 'title'
  sibling.card_tescription = body if type is 'description'
  Elements.update(sibling._id, sibling)

Meteor.methods
  resetCard: (id) ->
    Elements.remove(parent_id: id, header_element: { $exists: false })
    resetHeaderElements(id, defaults.card)
    updateSiblingElement(id, 'title', defaults.card.title)
    updateSiblingElement(id, 'description', defaults.element.description.body)

  deleteCard: (id, siblingElementId) ->
    Elements.remove(siblingElementId)
    Elements.remove(parent_id: id)
    Cards.remove(id)

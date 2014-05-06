@Cards = new Meteor.Collection('cards')

@createCard = (attributes) ->
  throw new Meteor.Error(422, 'Card needs a parent') unless attributes.parentId
  throw new Meteor.Error(422, 'Card type needs to be declared') unless attributes.type
  throw new Meteor.Error(422, 'Card type needs to be valid') unless _.contains(defaults.card.types, attributes.type)
  id = Cards.insert({})
  createHeaderElements(id, defaults.card)
  attributes.elementId = createElement
    type: 'card'
    body: id
    parentId: attributes.parentId
    cardType: attributes.type
    cardTitle: defaults.card.title
    cardDescription: defaults.element.description.body
  Cards.update(id, attributes)
  id

@updateCardType = (card, type) ->
  # must specify a valid type
  card.type = type
  Cards.update(card._id, card)
  updateSiblingElement(card._id, 'type', type)

@updateSiblingElement = (id, type, body) ->
  # must be valid type
  sibling = Elements.findOne(body: id, type: 'card')
  # error if not found element
  sibling.cardType = body if type is 'type'
  sibling.cardTitle = body if type is 'title'
  sibling.cardDescription = body if type is 'description'
  Elements.update(sibling._id, sibling)

Meteor.methods
  resetCard: (id) ->
    Elements.remove(parentId: id, headerElement: { $exists: false })
    resetHeaderElements(id, defaults.card)
    updateSiblingElement(id, 'title', defaults.card.title)
    updateSiblingElement(id, 'description', defaults.element.description.body)

  deleteCard: (id, siblingElementId) ->
    Elements.remove(siblingElementId)
    Elements.remove(parentId: id)
    Cards.remove(id)

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
    cardDescription: defaults.element.description
  Cards.update(id, attributes)
  id

@updateCardType = (card, type) ->
  card.type = type
  Cards.update(card._id, card)

@updateSiblingElement = (id, type, body) ->
  sibling = Elements.findOne(body: id, type: 'card')
  sibling.cardTitle = body if type is 'title'
  sibling.cardDescription = body if type is 'description'
  Elements.update(sibling._id, sibling)

Meteor.methods
  resetCard: (id) ->
    Elements.remove(parentId: id, headerElement: { $exists: false })
    resetHeaderElements(id, defaults.card)
    updateSiblingElement(id, 'title', defaults.card.title)
    updateSiblingElement(id, 'description', defaults.element.description)

  deleteCard: (id, siblingElementId) ->
    Elements.remove(siblingElementId)
    Elements.remove(parentId: id)
    Cards.remove(id)

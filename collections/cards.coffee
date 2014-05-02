@Cards = new Meteor.Collection('cards')

@createCard = (attributes) ->
  throw new Meteor.Error(422, 'Card needs a parent') unless attributes.parentId
  throw new Meteor.Error(422, 'Card type needs to be declared') unless attributes.type
  throw new Meteor.Error(422, 'Card type needs to be valid') unless _.contains(defaults.card.types, attributes.type)
  cardId = Cards.insert({})
  createElement
    type: 'title'
    body: defaults.card.title
    parentId: cardId
    belongsTo: 'card'
    headerElement: true
  createElement
    type: 'description'
    parentId: cardId
    belongsTo: 'card'
    headerElement: true
  attributes.elementId = createElement
    type: 'card'
    body: cardId
    parentId: attributes.parentId
    cardType: attributes.type
    cardTitle: defaults.card.title
    cardDescription: defaults.element.description
  Cards.update(cardId, attributes)
  cardId

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
    Elements.remove
      parentId: id
      headerElement: { $exists: false }
    Elements.update { parentId: id, type: 'title' },
      $set:
        body: defaults.card.title
        editable: true
    Elements.update { parentId: id, type: 'description' },
      $set:
        body: defaults.element.description
        editable: true
    updateSiblingElement(id, 'title', defaults.card.title)
    updateSiblingElement(id, 'description', defaults.element.description)

  deleteCard: (id, siblingElementId) ->
    Elements.remove(siblingElementId)
    Elements.remove(parentId: id)
    Cards.remove(id)

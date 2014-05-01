@Cards = new Meteor.Collection('cards')

@createCard = (attributes) ->
  typeWhitelist =
    accommodation: true
    travel: true
    event: true
  throw new Meteor.Error(422, 'Element needs a parent') unless attributes.parentId
  throw new Meteor.Error(422, 'Element type needs to be declared') unless attributes.type
  throw new Meteor.Error(422, 'Element type needs to be valid') unless attributes.type of typeWhitelist
  cardId = Cards.insert({})
  attributes.elementId = createElement
    type: 'title'
    body: 'Card title'
    parentId: cardId
    headerElement: true
  createElement
    type: 'description'
    parentId: cardId
    headerElement: true
  createElement
    type: 'card'
    body: cardId
    parentId: attributes.parentId
    cardType: attributes.type
    cardTitle: 'Card title'
    cardDescription: 'A short description'
  Cards.update(cardId, attributes)
  cardId

Meteor.methods
  resetCard: (id) ->
    Elements.remove
      parentId: id
      headerElement: { $exists: false }
    Elements.update { parentId: id, type: 'title' },
      $set:
        body: 'Card title'
        editable: true
    Elements.update { parentId: id, type: 'description' },
      $set:
        body: 'A short description'
        editable: true
    #somewhere needs to be default bodys

  deleteCard: (id) ->
    console.log('deleteCard', id)
    siblingElement = Cards.findOne(id).elementId
    Elements.remove(siblingElement)
    Elements.remove(parentId: id)
    Cards.remove(id)

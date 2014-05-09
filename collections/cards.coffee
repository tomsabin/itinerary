@Cards = new Meteor.Collection('cards')

Cards.before.insert (userId, doc) ->
  doc.document_type = defaults.card.document_type
  doc.user_id = userId

Cards.allow
  insert: (userId, doc) ->
    isOwner = userId and doc.user_id is userId
    isParentOwner = Itineraries.findOne(doc.parent_id).user_id is userId
    hasValidFields = not _.difference(Object.keys(doc), defaults.card.valid_insert_attributes).length
    if hasValidFields and isParentOwner and isOwner
      createHeaderElements(doc._id, defaults.card)
      elementId = Elements.insert
        type: 'card'
        body: doc._id
        parent_id: doc.parent_id
        card_type: doc.type
        card_title: defaults.card.title
        card_description: defaults.element.description.body
        belongs_to: 'card'
      doc.element_id = elementId
    hasValidFields and isParentOwner and isOwner
  remove: (userId, doc) ->
    isOwner = userId and doc.user_id is userId
    if isOwner
      Elements.remove(doc.element_id)
      Elements.remove(parent_id: doc._id)
      Cards.remove(doc._id)
    isOwner
  update: (userId, doc, fields, modifier) ->
    isOwner = userId and doc.user_id is userId
    onlyUpdateType = not _.difference(fields, ['type']).length
    hasValidType = _.contains(defaults.card.types, modifier.$set.type)
    if hasValidType and onlyUpdateType and isOwner
      updateSiblingElement(doc._id, 'type', modifier.$set.type)
    hasValidType and onlyUpdateType and isOwner

@updateSiblingElement = (id, type, body) ->
  validateOwner('Card', id, Meteor.user())
  sibling = Elements.findOne(body: id, type: 'card')
  throw new Meteor.Error(404, 'Sibling element not found') unless sibling?
  attributes = {}
  attributes.card_type = body if type is 'type'
  attributes.card_title = body if type is 'title'
  attributes.card_description = body if type is 'description'
  Elements.update { _id: sibling._id }, { $set: attributes }

Meteor.methods
  resetCard: (id) ->
    validateOwner('Card', id, Meteor.user())
    Elements.remove(parent_id: id, header_element: { $exists: false })
    resetHeaderElements(id, defaults.card)
    updateSiblingElement(id, 'title', defaults.card.title)
    updateSiblingElement(id, 'description', defaults.element.description.body)

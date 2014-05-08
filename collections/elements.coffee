@Elements = new Meteor.Collection 'elements',
  transform: (doc) ->
    _.extend(new Element(doc), Element.prototype, defaults.element[doc.type].prototype)

Elements.before.update (userId, doc) ->
  validateElement(userId, doc)

Elements.before.insert (userId, doc) ->
  validateElement(userId, doc)
  doc.body = defaults.element[doc.type].body unless doc.body?
  doc.user_id = userId
  doc.editable = true
  highestElement = Elements.findOne({ parent_id: doc.parent_id },
                     sort: { position: -1 }
                     limit: 1
                   )
  position = if highestElement? then highestElement.position else 0
  doc.position = position + 1

Elements.allow
  insert: (userId, doc) -> userId and doc.user_id is userId
  remove: (userId, doc) -> userId and doc.user_id is userId
  update: (userId, doc, fields, modifier) ->
    isOwner = userId and doc.user_id is userId
    hasValidFields = not _.difference(fields, defaults.element.valid_attributes).length
    hasValidFields and isOwner

@createHeaderElements = (parentId, parent) ->
  Elements.insert
    type: 'title'
    body: parent.title
    parent_id: parentId
    belongs_to: parent.type
    header_element: true
  Elements.insert
    type: 'description'
    parent_id: parentId
    belongs_to: parent.type
    header_element: true

@resetHeaderElements = (parentId, parent) ->
  Elements.update { parent_id: parentId, type: 'title' },
    $set:
      body: parent.title
      editable: true
  Elements.update { parent_id: parentId, type: 'description' },
    $set:
      body: defaults.element.description.body
      editable: true

@updateElement = (id, type, body) ->
  throw new Meteor.Error(422, 'Element type needs to be valid') unless _.contains(defaults.element.types, type)
  attributes = { editable: false }
  attributes.original_body = body if _.contains(['photo', 'link', 'datetime-local', 'date', 'time'], type)
  switch type
    when 'link'
      markdownLink = /\[([^\]]+)\]\(([^)]+)\)/.exec(body)
      if markdownLink
        attributes.body = markdownLink[2]
        attributes.second_body = markdownLink[1]
      else
        attributes.body = body
        attributes.second_body = 'A link to the interwebs'
    when 'datetime-local'
      if body.match(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}(:\d{2})?/)
        attributes.body = moment(body).format(defaults.dateformats.date)
        attributes.second_body = moment(body).format(defaults.dateformats.time)
      else if moment(body).isValid()
        attributes.body = moment(body).format(defaults.dateformats.datetime)
      else
        attributes.body = body
    when 'date'
      if moment(body).isValid()
        attributes.body = moment(body).format(defaults.dateformats.date)
      else
        attributes.body = body
    when 'time'
      formattableTime = moment("#{moment().format('YYYY-MM-DD')}T#{body}") # :(
      if moment(formattableTime).isValid()
        attributes.body = formattableTime.format(defaults.dateformats.time)
      else
        attributes.body = body
    else
      attributes.body = body
  Elements.update({ _id: id }, { $set: attributes })

Meteor.methods
  deleteElement: (id) ->
    user = Meteor.user()
    throw new Meteor.Error(401, 'You need to login first to be able to perform that') unless user
    element = Elements.findOne(id)
    throw new Meteor.Error(404, 'Element was not found') unless element
    throw new Meteor.Error(403, 'Element does not belong to you') unless user._id is element.user_id
    Elements.remove(id)

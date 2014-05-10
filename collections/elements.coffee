@Elements = new Meteor.Collection 'elements',
  transform: (doc) ->
    _.extend(new Element(doc), Element.prototype, defaults.element[doc.type].prototype)

Elements.before.insert (userId, doc) ->
  doc.body = defaults.element[doc.type].body unless doc.body?
  doc.user_id = userId
  doc.editable = if doc.type is 'divider' then false else true
  highestElement = Elements.findOne({ parent_id: doc.parent_id },
                     sort: { position: -1 }
                     limit: 1
                   )
  position = if highestElement? then highestElement.position else 0
  doc.position = position + 1

Elements.allow
  insert: (userId, doc) ->
    isOwner = userId and doc.user_id is userId
    parent = Itineraries.findOne(doc.parent_id) if doc.belongs_to is 'itinerary'
    parent = Cards.findOne(doc.parent_id) if doc.belongs_to is 'card'
    isParentOwner = parent.user_id is userId
    hasValidFields = not _.difference(Object.keys(doc), defaults.element.valid_insert_attributes).length
    hasValidType = _.contains(defaults.element.types, doc.type)
    hasValidType and hasValidFields and isParentOwner and isOwner
  remove: (userId, doc) -> userId and doc.user_id is userId
  update: (userId, doc, fields, modifier) ->
    isOwner = userId and doc.user_id is userId
    hasValidFields = not _.difference(fields, defaults.element.valid_editable_attributes).length
    hasValidFields and isOwner

@createHeaderElements = (parentId, parent) ->
  Elements.insert
    type: 'title'
    body: parent.title
    parent_id: parentId
    belongs_to: parent.document_type
    header_element: true
  Elements.insert
    type: 'description'
    parent_id: parentId
    belongs_to: parent.document_type
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

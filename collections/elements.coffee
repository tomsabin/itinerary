@Elements = new Meteor.Collection 'elements',
  transform: (doc) ->
    switch doc.type
      when 'title'
        _.extend(new Element(doc), Element.prototype, TitleElement.prototype)
      when 'description'
        _.extend(new Element(doc), Element.prototype, DescriptionElement.prototype)
      when 'divider'
        _.extend(new Element(doc), Element.prototype, DividerElement.prototype)
      when 'photo'
        _.extend(new Element(doc), Element.prototype, PhotoElement.prototype)
      when 'text'
        _.extend(new Element(doc), Element.prototype, TextElement.prototype)
      when 'link'
        _.extend(new Element(doc), Element.prototype, LinkElement.prototype)
      when 'date'
        _.extend(new Element(doc), Element.prototype, DateElement.prototype)
      when 'time'
        _.extend(new Element(doc), Element.prototype, TimeElement.prototype)
      when 'map'
        _.extend(new Element(doc), Element.prototype, MapElement.prototype)
    doc

@Elements.before.insert (userId, doc) ->
  highestElement = Elements.findOne({ parentId: doc.parentId },
                     sort: { position: -1 }
                     limit: 1
                   )
  position = if highestElement? then highestElement.position else 0
  doc.position = position + 1

@createElement = (attributes) ->
  typeWhitelist =
    description: true
    divider: true
    title: true
    photo: true
    text: true
    link: true
    date: true
    time: true
    map: true

  throw new Meteor.Error(422, 'Element type needs to be declared') unless attributes.type
  throw new Meteor.Error(422, 'Element type needs a parent') unless attributes.parentId
  throw new Meteor.Error(422, 'Element type needs to be valid') unless attributes.type of typeWhitelist

  switch attributes.type
    when 'description'
      attributes.body = 'A short description'
    when 'title'
      attributes.body = 'Itinerary title'
    when 'photo'
      attributes.body = 'Link a photo'
    when 'text'
      attributes.body = 'Add some text'
    when 'link'
      attributes.body = 'Link the interwebs'
    when 'date'
      attributes.body = 'Specify a date'
    when 'time'
      attributes.body = 'Specify a time'
    when 'map'
      attributes.body = 'Enter an address'

  attributes.editable = true
  Elements.insert(attributes)

@updateElement = (elementId, type, body) ->
  attributes = { editable: false }
  switch type
    when 'link'
      markdownLink = /\[([^\]]+)\]\(([^)]+)\)/.exec(body)
      if markdownLink
        attributes.body = markdownLink[2]
        attributes.second_body = markdownLink[1]
      else
        attributes.body = body
        attributes.second_body = 'A link to the interwebs'
    when 'date'
      if body.match(/\d{4}-\d{2}-\d{2}/)
        attributes.body = body.split('-').reverse().join('/')
      else
        attributes.body = body
    else
      attributes.body = body
  Elements.update({ _id: elementId }, { $set: attributes })

Meteor.methods
  deleteElement: (elementId) ->
    Elements.remove(elementId)

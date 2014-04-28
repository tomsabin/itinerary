@Elements = new Meteor.Collection('elements',
  transform: (doc) ->
    switch doc.type
      when 'divider'
        return new DividerElement(doc)
      when 'photo'
        return new PhotoElement(doc)
      when 'text'
        return new TextElement(doc)
      when 'link'
        return new LinkElement(doc)
      when 'date'
        return new DateElement(doc)
      when 'map'
        return new MapElement(doc)
    doc
)

@Elements.before.insert (userId, doc) ->
  highestElement = Elements.findOne({ parentId: doc.parentId },
                     sort: { position: -1 }
                     limit: 1
                   )
  position = if highestElement? then highestElement.position() else 0
  doc.position = position + 1

@createElement = (attributes) ->
  typeWhitelist =
    divider: true
    text: true
    link: true
    photo: true
    map: true
    date: true

  throw new Meteor.Error(422, 'Element type needs to be declared') unless attributes.type

  unless attributes.type of typeWhitelist
    throw new Meteor.Error(422, 'Element type needs to be valid')

  switch attributes.type
    when 'text'
      attributes.body = 'Add some text'
    when 'link'
      attributes.body = 'Link the interwebs'
    when 'photo'
      attributes.body = 'Upload a photo'
    when 'map'
      attributes.body = 'Enter an address'
    when 'date'
      attributes.body = 'Specify a date or time'

  attributes.editable = true
  Elements.insert attributes

Meteor.methods
  deleteElement: (elementId) ->
    Elements.remove elementId

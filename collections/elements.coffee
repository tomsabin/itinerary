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
      attributes.body = 'Enter an address or some coordinates'
    when 'date'
      attributes.body = 'Specify a date and time'

  attributes.editable = true
  Elements.insert attributes

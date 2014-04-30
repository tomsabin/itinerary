helpers =
  dateTimeElements:
    initalElement: (doc) ->
      element = helpers.createInitialElement(doc)
      element.setAttribute('type', doc.type)
      helpers.wrapElement(doc, element)
    finalElement: (doc) ->
      element = document.createElement('p')
      element.setAttribute('class', "item-#{doc.body} editable")
      element.setAttribute('contentEditable', true)
      element.innerText = doc.body
      helpers.wrapElement(doc, element)
  createInitialElement: (doc) ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'item-entry')
    element.setAttribute('type', 'text')
    element
  wrapElement: (doc, element, isHeaderElement = false) ->
    outer = document.createElement('div')
    inner = document.createElement('div')
    outer.setAttribute('data-element-id', doc._id)
    outer.setAttribute('data-body', doc.body)
    outer.setAttribute('data-item-type', doc.type)
    inner.appendChild(element) if element?
    unless isHeaderElement
      iconDelete = document.createElement('i')
      iconDelete.setAttribute('data-action', 'removeElement')
      iconDelete.setAttribute('class', 'fa fa-times remove-item')
      iconHandle = document.createElement('i')
      iconHandle.setAttribute('class', 'fa fa-sort handle')
      outer.setAttribute('data-sortable', true)
      outer.setAttribute('class', "item item-#{doc.type}")
      inner.setAttribute('class', 'item-content-container')
      inner.appendChild(iconHandle)
      outer.appendChild(iconDelete)
    outer.appendChild(inner)
    outer.outerHTML

@Element = (doc) ->
  @doc = doc
@DescriptionElement = ->
@DateTimeElement = ->
@DividerElement = ->
@PhotoElement = ->
@TitleElement = ->
@TextElement = ->
@LinkElement = ->
@DateElement = ->
@TimeElement = ->
@MapElement = ->

@Element.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    helpers.wrapElement(@, element)

@TitleElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('class', 'h1-entry')
    helpers.wrapElement(@, element, true)
  finalElement: ->
    element = document.createElement('h1')
    element.setAttribute('id', 'itineraryTitle')
    element.setAttribute('class', 'itinerary-h1 editable')
    element.setAttribute('contentEditable', true)
    element.innerText = @body
    helpers.wrapElement(@, element, true)

@DescriptionElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('class', 'h2-entry')
    helpers.wrapElement(@, element, true)
  finalElement: ->
    element = document.createElement('h2')
    element.setAttribute('id', 'itineraryDescription')
    element.setAttribute('class', 'itinerary-h2 editable')
    element.setAttribute('contentEditable', true)
    element.innerText = @body
    helpers.wrapElement(@, element, true)

@DividerElement.prototype =
  initalElement: -> helpers.wrapElement(@, null)
  finalElement: -> helpers.wrapElement(@, null)

@TextElement.prototype =
  finalElement: ->
    element = document.createElement('p')
    element.setAttribute('class', 'item-text editable')
    element.setAttribute('contentEditable', true)
    element.innerText = @body
    helpers.wrapElement(@, element)

@LinkElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('type', 'url')
    helpers.wrapElement(@, element)
  finalElement: ->
    element = document.createElement('a')
    element.setAttribute('class', 'item-link')
    element.setAttribute('href', @body)
    element.innerText = @second_body
    helpers.wrapElement(@, element)

@PhotoElement.prototype =
  finalElement: ->
    element = document.createElement('img')
    element.setAttribute('class', 'item-photo')
    element.setAttribute('src', @body)
    helpers.wrapElement(@, element)

@MapElement.prototype =
  finalElement: ->
    staticGoogleMap = "http://maps.googleapis.com/maps/api/staticmap?center=#{@body}&markers=color:red|#{@body}&zoom=13&size=492x320&sensor=false"
    linkElement = document.createElement('a')
    linkElement.setAttribute('href', "http://maps.google.com/?q=#{@body}")
    imageElement = document.createElement('img')
    imageElement.setAttribute('class', 'item-map')
    imageElement.setAttribute('src', staticGoogleMap)
    linkElement.appendChild(imageElement)
    divElement = document.createElement('div')
    divElement.appendChild(linkElement)
    textElement = document.createElement('p')
    textElement.setAttribute('class', 'item-map-text editable')
    textElement.setAttribute('contentEditable', true)
    textElement.innerText = @body
    divElement.appendChild(textElement)
    helpers.wrapElement(@, divElement)

@DateTimeElement.prototype =
  initalElement: -> helpers.dateTimeElements.initalElement(@)
  finalElement: -> helpers.dateTimeElements.finalElement(@)

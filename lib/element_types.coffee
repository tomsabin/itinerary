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
  wrapElement: (doc, element, isEditable = false, isHeaderElement = false) ->
    outer = document.createElement('div')
    inner = document.createElement('div')
    outer.setAttribute('data-element-id', doc._id)
    outer.setAttribute('data-body', doc.body)
    outer.setAttribute('data-item-type', doc.type)
    inner.appendChild(element) if element?
    unless isHeaderElement
      iconDelete = document.createElement('i')
      iconHandle = document.createElement('i')
      iconDelete.setAttribute('data-action', 'removeElement')
      iconDelete.setAttribute('class', 'fa fa-times remove-item')
      iconHandle.setAttribute('class', 'fa fa-sort handle')
      outer.setAttribute('data-sortable', true)
      outer.setAttribute('data-editable', true) if isEditable
      outer.setAttribute('class', "item item-#{doc.type}#{if isEditable then ' editable' else ''}")
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
    helpers.wrapElement(@, element, false, true)
  finalElement: ->
    element = document.createElement('h1')
    element.setAttribute('class', 'item-title editable')
    element.setAttribute('contentEditable', true)
    element.innerText = @body
    helpers.wrapElement(@, element, false, true)

@DescriptionElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('class', 'h2-entry')
    helpers.wrapElement(@, element, false, true)
  finalElement: ->
    element = document.createElement('h2')
    element.setAttribute('class', 'item-description editable')
    element.setAttribute('contentEditable', true)
    element.innerText = @body
    helpers.wrapElement(@, element, false, true)

@DividerElement.prototype =
  initalElement: -> helpers.wrapElement(@, null)
  finalElement: -> @initalElement()

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
    element.setAttribute('value', @original_body) if @original_body?
    helpers.wrapElement(@, element)
  finalElement: ->
    element = document.createElement('a')
    element.setAttribute('class', 'item-link')
    element.setAttribute('href', @body)
    element.innerText = @second_body
    helpers.wrapElement(@, element, true)

@PhotoElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('value', @original_body) if @original_body?
    helpers.wrapElement(@, element)
  finalElement: ->
    element = document.createElement('img')
    element.setAttribute('class', 'item-photo')
    element.setAttribute('src', @body)
    helpers.wrapElement(@, element, true)

@MapElement.prototype =
  finalElement: ->
    staticGoogleMap = "http://maps.googleapis.com/maps/api/staticmap?center=#{@body}&markers=color:red|#{@body}&zoom=13&size=492x320&sensor=false"
    divElement = document.createElement('div')
    linkElement = document.createElement('a')
    imageElement = document.createElement('img')
    textElement = document.createElement('p')
    imageElement.setAttribute('class', 'item-map')
    imageElement.setAttribute('src', staticGoogleMap)
    linkElement.setAttribute('href', "http://maps.google.com/?q=#{@body}")
    textElement.setAttribute('class', 'item-map-text editable')
    textElement.setAttribute('contentEditable', true)
    textElement.innerText = @body
    linkElement.appendChild(imageElement)
    divElement.appendChild(linkElement)
    divElement.appendChild(textElement)
    helpers.wrapElement(@, divElement)

@DateTimeElement.prototype =
  initalElement: -> helpers.dateTimeElements.initalElement(@)
  finalElement: -> helpers.dateTimeElements.finalElement(@)

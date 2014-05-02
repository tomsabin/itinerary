helpers =
  dateTimeElements:
    initalElement: (doc) ->
      element = helpers.createInitialElement(doc)
      element.setAttribute('type', doc.type)
      element.setAttribute('value', @original_body) if @original_body?
      helpers.wrapElement(doc, element)
    finalElement: (doc) ->
      divElement = document.createElement('p')
      dateElement = document.createElement('p')
      dateElement.setAttribute('class', "item-#{doc.body}")
      dateElement.textContent = doc.body
      divElement.appendChild(dateElement)
      if doc.second_body?
        timeElement = document.createElement('p')
        timeElement.setAttribute('class', 'item-datetime-time')
        timeElement.textContent = doc.second_body
        divElement.appendChild(timeElement)
      helpers.wrapElement(doc, divElement, true, true, true)
  createInitialElement: (doc) ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'item-entry')
    element.setAttribute('type', 'text')
    element
  wrapElement: (doc, element, isRemovable = true, isSortable = true, isEditable = false, isHeaderElement = false) ->
    outer = document.createElement('div')
    inner = document.createElement('div')
    outer.setAttribute('data-element-id', doc._id)
    outer.setAttribute('data-body', doc.body) if doc.body?
    outer.setAttribute('data-item-type', doc.type)
    inner.appendChild(element) if element?
    if isRemovable
      iconDelete = document.createElement('i')
      iconDelete.setAttribute('data-action', 'removeElement')
      iconDelete.setAttribute('class', 'fa fa-times remove-item')
      outer.appendChild(iconDelete)
    if isSortable
      iconHandle = document.createElement('i')
      iconHandle.setAttribute('class', 'fa fa-sort handle')
      outer.setAttribute('data-sortable', true)
      inner.appendChild(iconHandle)
    if isEditable
      outer.setAttribute('data-editable', true)
      outer.setAttribute('class', "item item-#{doc.type} editable")
    else
      outer.setAttribute('class', "item item-#{doc.type}") unless isHeaderElement
    if isHeaderElement
      outer.setAttribute('data-belongs-to', doc.belongsTo)
      outer.setAttribute('data-parent-id', doc.parentId)
    else
      inner.setAttribute('class', 'item-content-container')
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
@CardElement = ->
@MapElement = ->

@Element.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    helpers.wrapElement(@, element)

@TitleElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('class', 'h1-entry')
    helpers.wrapElement(@, element, false, false, false, true)
  finalElement: ->
    element = document.createElement('h1')
    element.setAttribute('class', 'item-title editable')
    element.setAttribute('contentEditable', true)
    element.textContent = @body
    helpers.wrapElement(@, element, false, false, false, true)

@DescriptionElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('class', 'h2-entry')
    helpers.wrapElement(@, element, false, false, false, true)
  finalElement: ->
    element = document.createElement('h2')
    element.setAttribute('class', 'item-description editable')
    element.setAttribute('contentEditable', true)
    element.textContent = @body
    helpers.wrapElement(@, element, false, false, false, true)

@DividerElement.prototype =
  initalElement: -> helpers.wrapElement(@, null)
  finalElement: -> @initalElement()

@TextElement.prototype =
  finalElement: ->
    element = document.createElement('p')
    element.setAttribute('class', 'item-text editable')
    element.setAttribute('contentEditable', true)
    element.textContent = @body
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
    element.textContent = @second_body
    helpers.wrapElement(@, element, true, true, true)

@PhotoElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('value', @original_body) if @original_body?
    helpers.wrapElement(@, element)
  finalElement: ->
    element = document.createElement('img')
    element.setAttribute('class', 'item-photo')
    element.setAttribute('src', @body)
    helpers.wrapElement(@, element, true, true, true)

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
    textElement.textContent = @body
    linkElement.appendChild(imageElement)
    divElement.appendChild(linkElement)
    divElement.appendChild(textElement)
    helpers.wrapElement(@, divElement)

@CardElement.prototype =
  initalElement: ->
    outer = document.createElement('div')
    linkElement = document.createElement('a')
    element = document.createElement('div')
    titleElement = document.createElement('h1')
    descriptionElement = document.createElement('p')
    iconHandle = document.createElement('i')
    outer.setAttribute('data-sortable', true)
    outer.setAttribute('data-element-id', @_id)
    outer.setAttribute('class', "item item-#{@type}")
    linkElement.setAttribute('href', "/card/#{@body}")
    element.setAttribute('class', 'item-action-container')
    titleElement.setAttribute('class', 'item-h1')
    titleElement.textContent = @cardTitle
    descriptionElement.setAttribute('class', 'item-text')
    descriptionElement.setAttribute('data-card-type', @cardType)
    descriptionElement.textContent = @cardDescription
    iconHandle.setAttribute('class', 'fa fa-sort handle')
    element.appendChild(titleElement)
    element.appendChild(descriptionElement)
    element.appendChild(iconHandle)
    linkElement.appendChild(element)
    outer.appendChild(linkElement)
    outer.outerHTML
  finalElement: -> @initalElement()

@DateTimeElement.prototype =
  initalElement: -> helpers.dateTimeElements.initalElement(@)
  finalElement: -> helpers.dateTimeElements.finalElement(@)

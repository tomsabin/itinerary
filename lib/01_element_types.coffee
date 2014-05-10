helpers =
  dateTimeElements:
    initalElement: (doc) ->
      element = helpers.createInitialElement(doc)
      element.setAttribute('type', doc.type)
      element.setAttribute('value', @original_body) if @original_body?
      helpers.wrapElement doc, element,
        isRemovable: true,
        isSortable: true,
        isEditable: false,
        isHeaderElement: false
    finalElement: (doc) ->
      divElement = document.createElement('p')
      dateElement = document.createElement('p')
      dateElement.setAttribute('class', "item-#{doc.type}")
      dateElement.setAttribute('data-inline-editable', true)
      dateElement.textContent = doc.body
      divElement.appendChild(dateElement)
      if doc.second_body?
        timeElement = document.createElement('p')
        timeElement.setAttribute('class', 'item-datetime-time')
        timeElement.setAttribute('data-inline-editable', true)
        timeElement.textContent = doc.second_body
        divElement.appendChild(timeElement)
      helpers.wrapElement doc, divElement,
        isRemovable: true,
        isSortable: true,
        isEditable: true,
        isHeaderElement: false
    uneditableElement: (doc) ->
      divElement = document.createElement('p')
      dateElement = document.createElement('p')
      dateElement.setAttribute('class', "item-#{doc.type}")
      dateElement.textContent = doc.body
      divElement.appendChild(dateElement)
      if doc.second_body?
        timeElement = document.createElement('p')
        timeElement.setAttribute('class', 'item-datetime-time')
        timeElement.textContent = doc.second_body
        divElement.appendChild(timeElement)
      helpers.wrapElement doc, divElement,
        isRemovable: false,
        isSortable: false,
        isEditable: false,
        isHeaderElement: false
  createFinalTitleElement: (doc, opts = {}) ->
    element = document.createElement('h1')
    element.setAttribute('class', "item-title #{if opts.editable then 'editable' else ''}")
    element.setAttribute('contentEditable', true) if opts.editable
    element.textContent = doc.body
    helpers.wrapElement doc, element,
      isRemovable: false,
      isSortable: false,
      isEditable: false,
      isHeaderElement: true
  createFinalDescriptionElement: (doc, opts = {}) ->
    element = document.createElement('h2')
    element.setAttribute('class', "item-description #{if opts.editable then 'editable' else ''}")
    element.setAttribute('contentEditable', true) if opts.editable
    element.textContent = doc.body
    helpers.wrapElement doc, element,
      isRemovable: false,
      isSortable: false,
      isEditable: false,
      isHeaderElement: true
  createFinalTextElement: (doc, opts = {}) ->
    element = document.createElement('p')
    element.setAttribute('class', "item-text #{if opts.editable then 'editable' else ''}")
    element.setAttribute('contentEditable', true) if opts.editable
    element.textContent = doc.body
    helpers.wrapElement doc, element,
      isRemovable: opts.editable,
      isSortable: opts.editable,
      isEditable: false,
      isHeaderElement: false
  createFinalLinkElement: (doc, opts = {}) ->
    element = document.createElement('a')
    element.setAttribute('class', 'item-link')
    element.setAttribute('href', doc.body)
    element.textContent = doc.second_body
    helpers.wrapElement doc, element,
      isRemovable: opts.editable,
      isSortable: opts.editable,
      isEditable: opts.editable,
      isHeaderElement: false
  createFinalPhotoElement: (doc, opts = {}) ->
    element = document.createElement('img')
    element.setAttribute('class', 'item-photo')
    element.setAttribute('src', doc.body)
    helpers.wrapElement doc, element,
      isRemovable: opts.editable,
      isSortable: opts.editable,
      isEditable: opts.editable,
      isHeaderElement: false
  createFinalMapElement: (doc, opts = {}) ->
    staticGoogleMap = "http://maps.googleapis.com/maps/api/staticmap?center=#{doc.body}&markers=color:red|#{doc.body}&zoom=13&size=492x320&sensor=false"
    divElement = document.createElement('div')
    linkElement = document.createElement('a')
    imageElement = document.createElement('img')
    textElement = document.createElement('p')
    imageElement.setAttribute('class', 'item-map')
    imageElement.setAttribute('src', staticGoogleMap)
    linkElement.setAttribute('href', "http://maps.google.com/?q=#{doc.body}")
    textElement.setAttribute('class', "item-map-text #{if opts.editable then 'editable' else ''}")
    textElement.setAttribute('contentEditable', true) if opts.editable
    textElement.textContent = doc.body
    linkElement.appendChild(imageElement)
    divElement.appendChild(linkElement)
    divElement.appendChild(textElement)
    helpers.wrapElement doc, divElement,
      isRemovable: opts.editable,
      isSortable: opts.editable,
      isEditable: false,
      isHeaderElement: false
  createCardElement: (doc, opts = {}) ->
    outer = document.createElement('div')
    linkElement = document.createElement('a')
    element = document.createElement('div')
    titleElement = document.createElement('h1')
    descriptionElement = document.createElement('p')
    iconHandle = document.createElement('i') if opts.editable
    outer.setAttribute('data-sortable', true) if opts.editable
    outer.setAttribute('data-element-id', doc._id)
    outer.setAttribute('class', "item item-#{doc.type}")
    linkElement.setAttribute('href', Router.path('card', _id: doc.body))
    element.setAttribute('class', 'item-action-container')
    titleElement.setAttribute('class', 'item-card-title')
    titleElement.textContent = doc.card_title
    descriptionElement.setAttribute('class', 'item-text')
    descriptionElement.setAttribute('data-card-type', doc.card_type)
    descriptionElement.textContent = doc.card_description
    iconHandle.setAttribute('class', 'fa fa-sort handle') if opts.editable
    element.appendChild(titleElement)
    element.appendChild(descriptionElement)
    element.appendChild(iconHandle) if opts.editable
    linkElement.appendChild(element)
    outer.appendChild(linkElement)
    outer.outerHTML
  createInitialElement: (doc) ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'item-entry')
    element.setAttribute('type', 'text')
    element
  wrapElement: (doc, element, opts = {}) ->
    outer = document.createElement('div')
    inner = document.createElement('div')
    outer.setAttribute('data-element-id', doc._id)
    outer.setAttribute('data-body', doc.body) if doc.body?
    outer.setAttribute('data-item-type', doc.type)
    inner.appendChild(element) if element?
    if opts.isRemovable
      iconDelete = document.createElement('i')
      iconDelete.setAttribute('data-action', 'removeElement')
      iconDelete.setAttribute('class', 'fa fa-times remove-item')
      outer.appendChild(iconDelete)
    if opts.isSortable
      iconHandle = document.createElement('i')
      iconHandle.setAttribute('class', 'fa fa-sort handle')
      outer.setAttribute('data-sortable', true)
      inner.appendChild(iconHandle)
    if opts.isEditable
      outer.setAttribute('data-editable', true)
      outer.setAttribute('class', "item item-#{doc.type} editable")
    else
      outer.setAttribute('class', "item item-#{doc.type}") unless opts.isHeaderElement
    if opts.isHeaderElement
      outer.setAttribute('data-deletable', false)
      outer.setAttribute('data-belongs-to', doc.belongs_to)
      outer.setAttribute('data-parent-id', doc.parent_id)
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
    helpers.wrapElement @, element,
      isRemovable: true,
      isSortable: true,
      isEditable: false,
      isHeaderElement: false

@TitleElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('class', 'title-entry')
    helpers.wrapElement @, element,
      isRemovable: false,
      isSortable: false,
      isEditable: false,
      isHeaderElement: true
  finalElement: -> helpers.createFinalTitleElement @, editable: true
  uneditableElement: -> helpers.createFinalTitleElement @, editable: false

@DescriptionElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('class', 'description-entry')
    helpers.wrapElement @, element,
      isRemovable: false,
      isSortable: false,
      isEditable: false,
      isHeaderElement: true
  finalElement: -> helpers.createFinalDescriptionElement @, editable: true
  uneditableElement: -> helpers.createFinalDescriptionElement @, editable: false

@DividerElement.prototype =
  initalElement: -> helpers.wrapElement(@, null)
  finalElement: -> @initalElement()
  uneditableElement: -> helpers.wrapElement(@, null, false, false)

@TextElement.prototype =
  finalElement: -> helpers.createFinalTextElement @, editable: true
  uneditableElement: -> helpers.createFinalTextElement @, editable: false

@LinkElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('type', 'url')
    element.setAttribute('value', @original_body) if @original_body?
    helpers.wrapElement @, element,
      isRemovable: true,
      isSortable: true,
      isEditable: false,
      isHeaderElement: false
  finalElement: -> helpers.createFinalLinkElement @, editable: true
  uneditableElement: -> helpers.createFinalLinkElement @, editable: false

@PhotoElement.prototype =
  initalElement: ->
    element = helpers.createInitialElement(@)
    element.setAttribute('value', @original_body) if @original_body?
    helpers.wrapElement @, element,
      isRemovable: true,
      isSortable: true,
      isEditable: false,
      isHeaderElement: false
  finalElement: -> helpers.createFinalPhotoElement @, editable: true
  uneditableElement: -> helpers.createFinalPhotoElement @, editable: false

@MapElement.prototype =
  finalElement: -> helpers.createFinalMapElement @, editable: true
  uneditableElement: -> helpers.createFinalMapElement @, editable: false

@CardElement.prototype =
  initalElement: -> helpers.createCardElement @, editable: true
  finalElement: -> @initalElement()
  uneditableElement: -> helpers.createCardElement @, editable: false

@DateTimeElement.prototype =
  initalElement: -> helpers.dateTimeElements.initalElement(@)
  finalElement: -> helpers.dateTimeElements.finalElement(@)
  uneditableElement: -> helpers.dateTimeElements.uneditableElement(@)

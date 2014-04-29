wrapElement = (doc, element, isHeaderElement = false) ->
  outer = document.createElement('div')
  inner = document.createElement('div')
  outer.setAttribute('data-element-id', doc._id)
  inner.setAttribute('data-item-type', doc.type)
  inner.setAttribute('data-body', doc.body)
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

createInitialElement = (doc) ->
  element = document.createElement('input')
  element.setAttribute('placeholder', doc.body)
  element.setAttribute('class', 'item-entry')
  element.setAttribute('type', 'text')
  element

@TitleElement = (doc) ->
  body: -> doc.body
  initalElement: ->
    element = createInitialElement(doc)
    element.setAttribute('class', 'h1-entry')
    wrapElement(doc, element, true)
  finalElement: ->
    element = document.createElement('h1')
    element.setAttribute('id', 'itineraryTitle')
    element.setAttribute('class', 'itinerary-h1')
    element.innerText = doc.body
    wrapElement(doc, element, true)

@DescriptionElement = (doc) ->
  body: -> doc.body
  initalElement: ->
    element = createInitialElement(doc)
    element.setAttribute('class', 'h2-entry')
    wrapElement(doc, element, true)
  finalElement: ->
    element = document.createElement('h2')
    element.setAttribute('id', 'itineraryDescription')
    element.setAttribute('class', 'itinerary-h2')
    element.innerText = doc.body
    wrapElement(doc, element, true)

@DividerElement = (doc) ->
  position: -> doc.position
  finalElement: -> wrapElement(doc, null)

@TextElement = (doc) ->
  position: -> doc.position
  editable: -> doc.editable
  initalElement: ->
    element = createInitialElement(doc)
    wrapElement(doc, element)
  finalElement: ->
    element = document.createElement('p')
    element.setAttribute('class', 'item-text')
    element.innerText = doc.body
    wrapElement(doc, element)

@LinkElement = (doc) ->
  position: -> doc.position
  editable: -> doc.editable
  initalElement: ->
    element = createInitialElement(doc)
    element.setAttribute('type', 'url')
    wrapElement(doc, element)
  finalElement: ->
    element = document.createElement('a')
    element.setAttribute('class', 'item-link')
    element.setAttribute('href', doc.body)
    element.innerText = doc.second_body
    wrapElement(doc, element)

@PhotoElement = (doc) ->
  position: -> doc.position
  editable: -> doc.editable
  initalElement: ->
    element = createInitialElement(doc)
    wrapElement(doc, element)
  finalElement: ->
    element = document.createElement('img')
    element.setAttribute('class', 'item-photo')
    element.setAttribute('src', doc.body)
    wrapElement(doc, element)

@MapElement = (doc) ->
  position: -> doc.position
  editable: -> doc.editable
  initalElement: ->
    element = createInitialElement(doc)
    wrapElement(doc, element)
  finalElement: ->
    staticGoogleMap = "http://maps.googleapis.com/maps/api/staticmap?center=#{doc.body}&markers=color:red|#{doc.body}&zoom=13&size=492x320&sensor=false"
    linkElement = document.createElement('a')
    linkElement.setAttribute('href', "http://maps.google.com/?q=#{doc.body}")
    imageElement = document.createElement('img')
    imageElement.setAttribute('class', 'item-map')
    imageElement.setAttribute('src', staticGoogleMap)
    divElement = document.createElement('div')
    divElement.setAttribute('class', 'item-map-text')
    divElement.innerText = doc.body

    linkElement.appendChild(imageElement)
    linkElement.insertBefore(divElement, divElement.nextSibling)
    wrapElement(doc, linkElement)

@DateElement = (doc) ->
  position: -> doc.position
  editable: -> doc.editable
  initalElement: ->
    element = createInitialElement(doc)
    element.setAttribute('type', 'date')
    wrapElement(doc, element)
  finalElement: ->
    element = document.createElement('p')
    element.setAttribute('class', 'item-date')
    element.innerText = doc.body
    wrapElement(doc, element)

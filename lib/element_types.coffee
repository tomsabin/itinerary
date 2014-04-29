# DRY up editable function somehow
wrap = (doc, el) ->
  outer = document.createElement('div')
  outer.setAttribute('data-sortable', true)
  outer.setAttribute('data-element-id', doc._id)
  outer.setAttribute('class', "item item-#{doc.type}")

  iconDelete = document.createElement('i')
  iconDelete.setAttribute('data-action', 'removeElement')
  iconDelete.setAttribute('class', 'fa fa-times remove-item')

  inner = document.createElement('div')
  inner.setAttribute('data-item-type', doc.type)
  inner.setAttribute('data-body', doc.body)
  inner.setAttribute('class', 'item-content-container')

  iconHandle = document.createElement('i')
  iconHandle.setAttribute('class', 'fa fa-sort handle')

  inner.appendChild(el) if el?
  inner.appendChild(iconHandle)
  outer.appendChild(iconDelete)
  outer.appendChild(inner)
  outer.outerHTML

headerWrap = (doc, el) ->
  outer = document.createElement('div')
  outer.setAttribute('data-element-id', doc._id)

  inner = document.createElement('div')
  inner.setAttribute('data-item-type', doc.type)
  inner.setAttribute('data-body', doc.body)

  inner.appendChild(el)
  outer.appendChild(inner)
  outer.outerHTML

@TitleElement = (doc) ->
  body: -> doc.body
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'h1-entry')
    element.setAttribute('type', 'text')
    headerWrap doc, element
  finalElement: ->
    element = document.createElement('h1')
    element.setAttribute('id', 'itineraryTitle')
    element.setAttribute('class', 'itinerary-h1')
    element.innerText = doc.body
    headerWrap doc, element

@DescriptionElement = (doc) ->
  body: -> doc.body
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'h2-entry')
    element.setAttribute('type', 'text')
    headerWrap doc, element
  finalElement: ->
    element = document.createElement('h2')
    element.setAttribute('id', 'itineraryDescription')
    element.setAttribute('class', 'itinerary-h2')
    element.innerText = doc.body
    headerWrap doc, element

@DividerElement = (doc) ->
  finalElement: -> wrap doc, null
  position: -> doc.position

@TextElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'item-entry')
    element.setAttribute('type', 'text')
    wrap doc, element
  finalElement: ->
    element = document.createElement('p')
    element.setAttribute('class', 'item-text')
    element.innerText = doc.body
    wrap doc, element

@LinkElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'item-entry')
    element.setAttribute('type', 'url')
    wrap doc, element
  finalElement: ->
    element = document.createElement('a')
    element.setAttribute('class', 'item-link')
    element.setAttribute('href', doc.body)
    element.innerText = doc.second_body
    wrap doc, element

@PhotoElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'item-entry')
    element.setAttribute('type', 'text')
    wrap doc, element
  finalElement: ->
    element = document.createElement('img')
    element.setAttribute('class', 'item-photo')
    element.setAttribute('src', doc.body)
    wrap doc, element

@MapElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'item-entry')
    element.setAttribute('type', 'text')
    wrap doc, element
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
    wrap doc, linkElement

@DateElement = (doc) ->
  editable: -> doc.editable
  position: -> doc.position
  initalElement: ->
    element = document.createElement('input')
    element.setAttribute('placeholder', doc.body)
    element.setAttribute('class', 'item-entry')
    element.setAttribute('type', 'date')
    wrap doc, element
  finalElement: ->
    element = document.createElement('p')
    element.setAttribute('class', 'item-date')
    element.innerText = doc.body
    wrap doc, element

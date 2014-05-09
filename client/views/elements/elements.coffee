updateElementWithEvent = (e) ->
  findAttribute = (target, attribute) ->
    if target.parentElement.parentElement.parentElement.getAttribute('data-item-type') is 'map' and target.localName isnt 'input'
      target.parentElement.parentElement.parentElement.getAttribute(attribute)
    else
      target.parentElement.parentElement.getAttribute(attribute)

  target = e.target
  if target? and target.localName is 'input' or target.getAttribute('contentEditable')?
    body = if target.localName is 'input' then target.value else target.textContent
    if !!body
      updateElement(
        findAttribute(target, 'data-element-id'),
        findAttribute(target, 'data-item-type'),
        body)
      if findAttribute(target, 'data-belongs-to') is 'card'
        updateSiblingElement(
          findAttribute(target, 'data-parent-id'),
          findAttribute(target, 'data-item-type'),
          body)
    else
      originalBody = findAttribute(target, 'data-body')
      if target.getAttribute('contentEditable')?
        target.textContent = originalBody
      else unless target.localName is 'input'
        target.value =  originalBody
      else if _.contains(['datetime-local', 'date', 'time'], target.getAttribute('type'))
        id = e.target.parentElement.parentElement.getAttribute('data-element-id')
        Elements.update({ _id: id }, { $set: editable: false }) unless /specify a/i.test(originalBody)

toggleElementEditable = (id) ->
  Elements.update({ _id: id }, { $set: editable: true })
  $("[data-element-id='#{id}'] input").waitUntilExists -> @focus()

Template.elements.events
  'click [data-inline-editable="true"]': (e) ->
    toggleElementEditable e.target.parentElement.parentElement.getAttribute('data-element-id')
  'click [data-editable="true"]': (e) ->
    toggleElementEditable e.target.parentElement.getAttribute('data-element-id')
  'click [data-action="removeElement"]': (e) ->
    Meteor.call('deleteElement', e.target.parentElement.getAttribute('data-element-id'))
  'keydown': (e) -> if e.which is 13 and e.target.localName is 'input'
    updateElementWithEvent(e)
  'keyup': (e) -> if e.which is 27 and e.target.localName is 'input'
    parent = e.target.parentElement.parentElement
    Meteor.call('deleteElement', parent.getAttribute('data-element-id')) unless parent.getAttribute('data-deletable')
  'focusout': (e) -> updateElementWithEvent(e)

Template.elements.rendered = ->
  $elementList = $('#elementList')
  $elementList.sortable
    axis: 'y'
    handle: '.handle'
    items: 'div[data-sortable="true"]'
    placeholder: 'item-placeholder'
    forcePlaceholderSize: '80px'
    stop: (event, ui) ->
      _.each $(event.target).children('div'), (element, index, list) ->
        Elements.update { _id: element.getAttribute('data-element-id') },
          $set: position: index + 1

  if Session.get('selectTitleElement')
    $('div[data-item-type="title"] input').waitUntilExists ->
      Session.set('selectTitleElement', '')
      @focus()

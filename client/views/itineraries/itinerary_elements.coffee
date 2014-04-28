getElementId = (e) ->
  e.target.parentElement.parentElement.getAttribute('data-element-id')

Template.itineraryElements.events
  focusout: (e) ->
    if e.target.localName is 'input'
      body = e.target.value
      if !!body
        updateElement(getElementId(e), e.target.getAttribute('data-item-type'), body)

    else if e.target.getAttribute('contentEditable')?
      originalBody = e.target.parentElement.getAttribute('data-body')
      body = e.target.innerText
      if !!body
        updateElement(getElementId(e), e.target.getAttribute('data-item-type'), body)
      else
        e.target.innerText = originalBody

  keypress: (e) ->
    if e.which is 13
      Elements.update
        _id: getElementId(e)
      ,
        $set:
          body: if (e.target.localName is 'input') then e.target.value else e.target.innerText
          editable: false

  'click [data-action="removeElement"]': (e) ->
    Meteor.call('deleteElement', e.target.parentElement.getAttribute('data-element-id'))

Template.itineraryElements.rendered = ->
  $elementList = $('#elementList')
  $elementList.sortable
    axis: 'y'
    handle: '.handle'
    placeholder: 'item-placeholder'
    forcePlaceholderSize: '80px'
    stop: (event, ui) ->
      _.each $(event.target).children('div'), (element, index, list) ->
        Elements.update { _id: element.getAttribute('data-element-id') },
          $set: position: index + 1

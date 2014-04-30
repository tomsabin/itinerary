Template.elements.helpers
  focusOnTitleElementIfFirstCreated: ->
    if Session.get('selectTitleElement')
      element = $('input[data-item-type="title"')
      if element.length > 0
        element.focus()
        Session.set('selectTitleElement', '')

updateElementWithEvent = (e) ->
  target = e.target
  if target? and target.localName is 'input'
    originalBody = target.parentElement.getAttribute('data-body')
    body = target.value
    if !!body
      updateElement(
        target.parentElement.parentElement.getAttribute('data-element-id'),
        target.parentElement.getAttribute('data-item-type'),
        body)
    else
      target.value = originalBody unless target.localName is 'input'

Template.elements.events
  focusout: (e) -> updateElementWithEvent(e)
  keypress: (e) -> updateElementWithEvent(e) if e.which is 13
  'click [data-action="removeElement"]': (e) ->
    Meteor.call('deleteElement', e.target.parentElement.getAttribute('data-element-id'))

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
    @.$('div[data-item-type="title"] input').focus()
    Session.set('selectTitleElement', '')

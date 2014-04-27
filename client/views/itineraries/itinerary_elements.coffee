Template.itineraryElements.events
  focusout: (e) ->
    if e.target.getAttribute('contentEditable')?
      Elements.update
        _id: e.target.parentElement.getAttribute('data-element-id')
      ,
        $set:
          body: e.target.innerText
          editable: false

  'click #removeElement': (e) ->
    Meteor.call('deleteElement', e.target.parentElement.getAttribute('data-element-id'))

Template.itineraryElements.rendered = ->
  Deps.autorun ->
    $elementList = $('#elementList')
    $elementList.sortable
      handle: '.handle'
      stop: (event, ui) ->
        _.each $(event.target).children('div'), (element, index, list) ->
          Elements.update { _id: element.getAttribute('data-element-id') },
            $set: position: index + 1
    # $elementList.disableSelection()

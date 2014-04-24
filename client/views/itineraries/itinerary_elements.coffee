Template.itineraryElements.events
  focusout: (e) ->
    if e.target.getAttribute('contentEditable')?
      Elements.update
        _id: e.target.parentElement.getAttribute('data-element-id')
      ,
        $set:
          body: e.target.innerText
          editable: false

  'click input': (e) ->
    if e.target.getAttribute('data-action') is 'removeElement'
      Meteor.call('deleteElement', e.target.parentElement.getAttribute('data-element-id'))

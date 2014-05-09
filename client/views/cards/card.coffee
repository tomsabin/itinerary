Template.card.id = -> @_id

Template.card.types = ->
  [
    {type: 'accommodation', selected: @type is 'accommodation'},
    {type: 'travel',        selected: @type is 'travel'},
    {type: 'event',         selected: @type is 'event'}
  ]

Template.card.type = ->
  divElement = document.createElement('div')
  divElement.setAttribute('class', 'buttons-cell')
  divElement.setAttribute('data-card-type', @type)
  divElement.setAttribute('data-selected', true) if @selected
  divElement.outerHTML

Template.card.events
  'click #back': ->
    Router.go('itinerary', _id: @card.parent_id)
  'click [data-card-type]': (e) ->
    Cards.update { _id: e.target.parentElement.getAttribute('data-card-id') },
      $set: type: e.target.getAttribute('data-card-type')

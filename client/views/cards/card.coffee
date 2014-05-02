Template.card.types = ->
  [
    {type: 'accommodation', selected: @card.type is 'accommodation'},
    {type: 'travel',        selected: @card.type is 'travel'},
    {type: 'event',         selected: @card.type is 'event'}
  ]

Template.card.type = ->
  divElement = document.createElement('div')
  divElement.setAttribute('class', "buttons-cell")
  divElement.setAttribute('data-card-type', @type)
  divElement.setAttribute('data-selected', true) if @selected
  divElement.outerHTML

@setCard = (card) -> @card = card

Template.card.events
  'click #back': ->
    Router.go('itinerary', _id: card.parentId)
  'click [data-card-type]': (e) ->
    updateCardType(card, e.target.getAttribute('data-card-type'))

Template.card.rendered = -> setCard(@data.card)

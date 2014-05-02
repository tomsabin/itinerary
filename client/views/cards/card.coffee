Template.card.types = ->
  [
    {type: 'accommodation', selected: @card.type is 'accommodation'},
    {type: 'travel',        selected: @card.type is 'travel'},
    {type: 'event',         selected: @card.type is 'event'}
  ]

Template.card.type = ->
  divElement = document.createElement('div')
  divElement.setAttribute('class', "buttons-cell card-#{@type}")
  divElement.setAttribute('data-card-type', @type)
  divElement.setAttribute('data-selected', true) if @selected
  divElement.outerHTML

@card = (card) -> @card = card

Template.card.events
  'click [data-card-type]': (e) ->
    updateCardType(card, e.target.getAttribute('data-card-type'))
  focusin: ->
    showOpeners()

Template.card.rendered = -> card(@data.card)

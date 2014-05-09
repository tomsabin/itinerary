Template.addCard.events
  'click #openCardsContainer': ->
    openCardsContainer()

  'click [data-action="addCard"]': (e) ->
    if @itinerary?
      cardId = Cards.insert
        type: e.target.getAttribute('data-card-type')
        parent_id: @itinerary._id,
        (error) -> unless error
          Session.set('selectTitleElement', true)
          Router.go('card', _id: cardId)

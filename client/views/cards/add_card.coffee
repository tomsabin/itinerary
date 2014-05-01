Template.addCard.events
  'click #openCardsContainer': ->
    openCardsContainer()

  'click [data-action="addCard"]': (e) ->
    if @itinerary?
      cardId = createCard
        type: e.target.getAttribute('data-card-type')
        parentId: @itinerary._id
      Session.set('selectTitleElement', true)
      Router.go('card', _id: cardId)

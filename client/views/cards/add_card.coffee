Template.addCard.events
  'click #openCardsContainer': ->
    openCardsContainer()

  'click [data-action="addCard"]': (e) ->
    if @itinerary?
      createCard
        type: e.target.getAttribute('data-card-type')
        parentId: @itinerary._id
      showOpeners()

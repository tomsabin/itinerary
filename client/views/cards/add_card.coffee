Template.addCard.events
  'click #openCardsContainer': ->
    openCardsContainer()

  'click [data-action="addCard"]': (e) ->
    if @?
      Cards.insert
        type: e.target.getAttribute('data-card-type')
        parent_id: @_id,
        (error, id) -> unless error
          Session.set('selectTitleElement', true)
          Router.go('card', _id: id)

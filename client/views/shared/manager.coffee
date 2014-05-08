Template.manager.events
  'click #clear': ->
    showOpeners()
    if confirm('Are you sure you want to reset all data?')
      if @itinerary?
        Meteor.call('resetItinerary', @itinerary._id)
      if @card?
        Meteor.call('resetCard', @card._id)

  'click #delete': ->
    showOpeners()
    if confirm('Are you sure you want to delete?')
      if @itinerary?
        Itineraries.remove @itinerary._id, (error) ->
          Router.go('itineraries') unless error
      if @card?
        Meteor.call('deleteCard', @card._id, @card.elementId)
        Router.go('itinerary', _id: @card.parent_id)

Template.manager.rendered = ->
  $(document).keyup (e) ->
    showOpeners() if e.which is 27
  $('#window').click ->
    showOpeners()
  hideContainers()

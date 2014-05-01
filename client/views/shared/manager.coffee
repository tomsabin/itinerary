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
        Meteor.call('deleteItinerary', @itinerary._id)
        Router.go('/')
      if @card?
        Meteor.call('deleteCard', @card._id)
        Router.go('/')

Template.manager.rendered = ->
  $('#window').click ->
    showOpeners()
  hideContainers()

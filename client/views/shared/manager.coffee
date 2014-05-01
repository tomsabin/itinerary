Template.manager.events
  'click #clear': ->
    showOpeners()
    if confirm('Are you sure you want to reset all data?')
      if @itinerary?
        console.log('reset itinerary')
      if @card?
        console.log('reset card')

  'click #delete': ->
    showOpeners()
    if confirm('Are you sure you want to delete?')
      if @itinerary?
        console.log('delete itinerary')
      if @card?
        console.log('delete card')

Template.manager.rendered = ->
  $('#window').click ->
    showOpeners()
  hideContainers()

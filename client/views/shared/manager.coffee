Template.manager.events
  'click #clear': ->
    showOpeners()
    if confirm('Are you sure you want to reset all data?')
      Meteor.call('resetItinerary', @_id) if @document_type is 'itinerary'
      Meteor.call('resetCard', @._id) if @document_type is 'card'

  'click #delete': ->
    showOpeners()
    if confirm('Are you sure you want to delete?')
      if @document_type is 'itinerary'
        Itineraries.remove @_id, (error) ->
          Router.go('itineraries') unless error
      if @document_type is 'card'
        parentId = @parent_id
        Cards.remove @_id, (error) ->
          Router.go('itinerary', _id: parentId) unless error

Template.manager.rendered = ->
  $(document).keyup (e) ->
    showOpeners() if e.which is 27
  $('#window').click ->
    showOpeners()
  hideContainers()

Template.itineraryHeader.events
  focusout: (e) ->
    if e.target.id is 'itineraryTitle'
      Itineraries.update { _id: @itinerary._id }, { $set: title: e.target.innerText }
    else if e.target.id is 'itineraryDescription'
      Itineraries.update { _id: @itinerary._id }, { $set: description: e.target.innerText }

Template.itineraryButtons.events
  'click #clearItinerary': ->
    if confirm('Are you sure you want to reset all data?')
      Meteor.call('clearItineraryElements', @itinerary._id)
      Itineraries.update { _id: @itinerary._id }, { $set: defaultItinerariesValues() }

  'click #deleteItinerary': ->
    if confirm('Are you sure you want to delete?')
      Meteor.call('clearItineraryElements', @itinerary._id)
      Itineraries.remove @itinerary._id
      Router.go('/')

  'click #addElement': (e) ->
    createElement
      type: e.target.getAttribute('data-element-type')
      parentId: @itinerary._id

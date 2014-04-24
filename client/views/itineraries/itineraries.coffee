defaultItinerariesValues = ->
  title: 'Itinerary title'
  description: 'A short description'

Template.itineraryHeader.events
  focusout: (e) ->
    if e.target.id is 'itineraryTitle'
      console.log('update title')
      Itineraries.update { _id: @itinerary._id }, { $set: title: e.target.innerText }
    else if e.target.id is 'itineraryDescription'
      console.log('update description')
      Itineraries.update { _id: @itinerary._id }, { $set: description: e.target.innerText }

Template.clearItineraries.events
  'click #clearItineraries': ->
    if confirm('Are you sure you want to clear all data?')
      Itineraries.update { _id: @itinerary._id }, { $set: defaultItinerariesValues() }

defaultItineraryValues = ->
  title: 'Itinerary title'
  description: 'A short description'

Template.itineraryHeader.events
  focusout: (e) ->
    if e.target.id is 'itineraryTitle'
      Itinerary.update { _id: itineraryId() }, { $set: title: e.target.innerText }
    else if e.target.id is 'itineraryDescription'
      Itinerary.update { _id: itineraryId() }, { $set: description: e.target.innerText }

Template.clearItinerary.events
  'click #clearItinerary': ->
    Itinerary.update { _id: itineraryId() }, { $set: defaultItineraryValues() } if confirm('Are you sure you want to clear all data?')

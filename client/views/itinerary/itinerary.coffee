Template.itineraryHeader.events
  focusout: (e) ->
    updateHash = if e.target.id is 'itineraryTitle'
                   title: e.target.innerText
                 else if e.target.id is 'itineraryDescription'
                   description: e.target.innerText
    Itinerary.update { _id: itineraryId() }, { $set: updateHash }

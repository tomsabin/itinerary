Template.itineraryHeader.events({
  'focusout': function (e) {
    var updateHash = {}
    if (e.target.id === 'itineraryTitle') {
      updateHash = { title: e.target.innerText }
    } else if (e.target.id === 'itineraryDescription') {
      updateHash = { description: e.target.innerText }
    }
    Itinerary.update({ _id: itineraryId() }, { $set : updateHash });
  }
});

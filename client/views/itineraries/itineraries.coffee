Template.itineraries.helpers
  itineraryTitle: ->
    titleElement = Elements.findOne(parent_id: this._id, type: 'title')
    if titleElement? then titleElement.body else defaults.itinerary.title
  itineraryDescription: ->
    descriptionElement = Elements.findOne(parent_id: this._id, type: 'description')
    if descriptionElement? then descriptionElement.body else defaults.element.description.body

Template.itineraries.events
  'click #newItinerary': ->
    itineraryId = createItinerary()
    Session.set('selectTitleElement', true)
    Router.go('itinerary', _id: itineraryId)

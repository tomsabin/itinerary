Template.itineraries.helpers
  title: ->
    titleElement = Elements.findOne(parentId: this._id, type: 'title')
    if titleElement? then titleElement.body else defaults.itinerary.title
  description: ->
    descriptionElement = Elements.findOne(parentId: this._id, type: 'description')
    if descriptionElement? then descriptionElement.body else defaults.element.description

Template.itineraries.events
  'click #newItinerary': ->
    itineraryId = createItinerary()
    Session.set('selectTitleElement', true)
    Router.go('itinerary', _id: itineraryId)

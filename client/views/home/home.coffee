Template.home.helpers
  title: ->
    titleElement = Elements.findOne({parentId: this._id, type: 'title'})
    if titleElement? then titleElement.body else 'Itinerary title'
  description: ->
    descriptionElement = Elements.findOne({parentId: this._id, type: 'description'})
    if descriptionElement? then descriptionElement.body else 'A short description'

Template.home.events
  'click #newItinerary': ->
    itineraryId = createItinerary()
    Session.set('selectTitleElement', true)
    Router.go('itinerary', _id: itineraryId)

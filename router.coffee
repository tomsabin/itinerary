Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'home',
    path: '/'
    data: ->
      itineraries: Itineraries.find()
    waitOn: ->
      Meteor.subscribe('itineraries')

  @route 'itinerary',
    path: '/:_id'
    data: ->
      elements: Elements.find(parentId: @params._id)
      itinerary: Itineraries.findOne(@params._id)
    waitOn: -> [
      Meteor.subscribe('singleItinerary', @params._id)
      Meteor.subscribe('elements', @params._id)
    ]

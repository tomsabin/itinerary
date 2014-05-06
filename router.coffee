Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

Router.onBeforeAction('loading');

Router.map ->
  @route 'itineraries',
    path: '/'
    data: ->
      itineraries: Itineraries.find {},
                     sort: { created_on: 1 }
    waitOn: -> [
      Meteor.subscribe('itineraries')
      Meteor.subscribe('headerElements')
    ]

  @route 'card',
    path: '/c/:_id'
    data: ->
      card: Cards.findOne(@params._id)
      elements: Elements.find { parentId: @params._id },
                  sort: { position: 1 }
    waitOn: -> [
      Meteor.subscribe('card', @params._id)
      Meteor.subscribe('elements', @params._id)
      Meteor.subscribe('siblingElement', @params._id)
    ]
    # need to return something falsey here?
    # notFoundTemplate or something to redirect to 'notFound'


  @route 'itinerary',
    path: '/i/:_id'
    data: ->
      itinerary: Itineraries.findOne(@params._id)
      elements: Elements.find { parentId: @params._id },
                  sort: { position: 1 }
    waitOn: -> [
      Meteor.subscribe('itinerary', @params._id)
      Meteor.subscribe('elements', @params._id)
    ]

   @route('notFound', { path: '*' });


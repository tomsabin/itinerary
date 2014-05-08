mustBeLoggedIn = ->
  if Meteor.user()
    return
  else if Meteor.loggingIn()
    @render('loading')
  else
    Router.go('landingPage')

Router.onBeforeAction(mustBeLoggedIn, except: 'landingPage')
Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'

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

  @route 'landingPage', path: '/'

  @route 'itinerary',
    path: '/i/:_id'
    data: ->
      itinerary: Itineraries.findOne(@params._id)
      elements: Elements.find { parent_id: @params._id },
                  sort: { position: 1 }
    waitOn: -> [
      Meteor.subscribe('itinerary', @params._id)
      Meteor.subscribe('elements', @params._id)
    ]

  @route 'card',
    path: '/c/:_id'
    data: ->
      card: Cards.findOne(@params._id)
      elements: Elements.find { parent_id: @params._id },
                  sort: { position: 1 }
    waitOn: -> [
      Meteor.subscribe('card', @params._id)
      Meteor.subscribe('elements', @params._id)
      Meteor.subscribe('siblingElement', @params._id)
    ]

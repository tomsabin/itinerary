Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'itinerary', path: '/'
  @route 'card', path: '/card'

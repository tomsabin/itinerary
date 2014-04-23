Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'home', path: '/'
  @route 'card', path: '/card'

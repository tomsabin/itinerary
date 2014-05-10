@resetFormError = -> Session.set('formError', '')

Meteor.autorun ->
  resetFormError()
  if Meteor.user() and Router.current() and Router.current().route.name is 'landingPage'
    Router.go('itineraries')

Template.accounts.events
  'click [data-form-type]': (e) ->
    Session.set('formType', e.currentTarget.getAttribute('data-form-type'))
    resetFormError()
    openForm()
    $('#username').focus()

Template.accounts.rendered = ->
  showFormOpeners()
  $('#window, .home-title').click ->
    resetFormError()
    showFormOpeners()
  if Session.get('openRegistrationForm') is true
    Session.set('openRegistrationForm', '')
    Session.set('formType', 'registration')
    openForm()
    $('#username').focus()

Template.logout.events
  'click #logoutUser': -> Meteor.logout()

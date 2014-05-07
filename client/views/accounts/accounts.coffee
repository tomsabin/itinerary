@resetFormError = -> Session.set('formError', '')

Meteor.autorun ->
  resetFormError()
  if Meteor.user() and Router.current().route.name is 'landingPage'
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

Template.logout.events
  'click #logoutUser': -> Meteor.logout()

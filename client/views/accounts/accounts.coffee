Meteor.autorun ->
  Session.set('formError', '')
  if Meteor.user() and Router.current().route.name is 'landingPage'
    Router.go('itineraries')

Template.accounts.events
  'click #showLoginForm': (e) ->
    hideLoginRegistrationOpeners()
    $('#registrationForm').hide()
    $('#loginForm').show()
    $('#loginUsername').focus()
  'click #showRegistrationForm': (e) ->
    hideLoginRegistrationOpeners()
    $('#registrationForm').show()
    $('#loginForm').hide()
    $('#registrationUsername').focus()

Template.accounts.errorMessage = ->
  Session.get('formError')

Template.accounts.rendered = ->
  showLoginRegistrationOpeners()
  $('#window, .home-title').click ->
    Session.set('formError', '')
    showLoginRegistrationOpeners()

Template.login.events
  'submit form': (e, t) ->
    Session.set('formError', '')
    e.preventDefault()
    if !!t.find('#loginUsername').value
      Meteor.loginWithPassword(
        t.find('#loginUsername').value,
        t.find('#loginPassword').value,
        (error) ->
          if error
            Session.set('formError', error.reason)
          else
            Router.go('itineraries'))

Template.register.events
  'submit form': (e, t) ->
    Session.set('formError', '')
    e.preventDefault()
    if !!t.find('#registrationUsername').value
      try
        Accounts.createUser
          username: t.find('#registrationUsername').value
          password: t.find('#registrationPassword').value,
          (error) ->
            if error
              Session.set('formError', error.reason)
            else
              Router.go('itineraries')
      catch error
        Session.set('formError', 'Please enter a password') if error.message is 'Must set options.password'

Template.logout.events
  'click #logoutUser': -> Meteor.logout()

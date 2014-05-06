Meteor.autorun ->
  if Meteor.user() and Router.current().route.name is 'landingPage'
    Router.go('itineraries')

Template.login.events
  'click #submitLogin': (e, t) ->
    e.preventDefault()
    username = t.find('#loginUsername').value
    password = t.find('#loginPassword').value

    Meteor.loginWithPassword username, password, (error) ->
      if error
        console.log(error)
        $('#error-message').html(error.reason)
      else
        Router.go('itineraries')

Template.register.events
  'click #submitRegistration': (e, t) ->
    e.preventDefault()
    password = t.find('#registrationPassword').value
    passwordConfirmation = t.find('#registrationPasswordConfirmation').value
    if password isnt passwordConfirmation
      $('#error-message').html('Passwords much match')
    else if !password or !passwordConfirmation
      $('#error-message').html('Please enter a password')
    else
      Accounts.createUser
        username: t.find('#registrationUsername').value
        password: password,
        (error) ->
          if error
            console.log(error)
            $('#error-message').html(error.reason)
          else
            Router.go('itineraries')

Template.logout.events
  'click #logoutUser': -> Meteor.logout()

Accounts._loginButtonsSession.set('dropdownVisible', true)
Accounts.ui.config(passwordSignupFields: 'USERNAME_ONLY')

Meteor.autorun ->
  Router.go('itineraries') if Meteor.user() and Router.current().route.name is 'landingPage'

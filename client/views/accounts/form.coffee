formTypeIsRegistration = -> Session.get('formType') is 'registration'
createButton = (options) ->
  outerElement = document.createElement(options.outerElementName)
  spanElement = document.createElement('span')
  iconElement = document.createElement('i')
  divElement = document.createElement('div')
  outerElement.setAttribute(options.attributeName, options.attributeValue)
  outerElement.setAttribute('class', 'item item-button')
  divElement.setAttribute('class', 'item-action-container')
  spanElement.setAttribute('class', 'item-action-text')
  spanElement.textContent = options.spanText
  iconElement.setAttribute('class', "fa #{options.iconClass} item-action-icon")
  divElement.appendChild(spanElement)
  divElement.appendChild(iconElement)
  outerElement.appendChild(divElement)
  outerElement.outerHTML

Template.form.formSubmitButton = ->
  createButton
    outerElementName: 'button'
    attributeName: 'type'
    attributeValue: 'submit'
    spanText: if formTypeIsRegistration() then 'Create account' else 'Sign in'
    iconClass: if formTypeIsRegistration() then 'fa-user' else 'fa-sign-in'

Template.form.toggleFormSubmitButton = ->
  createButton
    outerElementName: 'div'
    attributeName: 'data-form-type'
    attributeValue: if formTypeIsRegistration() then 'login' else 'registration'
    spanText: if formTypeIsRegistration() then 'Sign in' else 'Create an account'
    iconClass: if formTypeIsRegistration() then 'fa-sign-in' else 'fa-user'

Template.form.errorMessage = ->
  Session.get('formError')

Template.form.events
  'submit form': (e, t) ->
    reportError = (error) ->
      if error
        Session.set('formError', error.reason)
      else
        Router.go('itineraries')
    e.preventDefault()
    resetFormError()
    username = t.find('#username').value
    password = t.find('#password').value
    if !!username
      if Session.get('formType') is 'registration'
        try
          Accounts.createUser { username: username, password: password },
            (error) -> reportError(error)
        catch error
          if error.message is 'Must set options.password'
            Session.set('formError', 'Please enter a password')
      else
        Meteor.loginWithPassword username, password,
          (error) -> reportError(error)

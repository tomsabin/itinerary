Handlebars.registerHelper 'documentOwner', ->
  @user_id is Meteor.userId()
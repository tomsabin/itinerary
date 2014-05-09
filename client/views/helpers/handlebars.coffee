Handlebars.registerHelper 'documentOwner', (doc = @) ->
  doc.user_id is Meteor.userId()
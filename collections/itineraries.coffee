@Itineraries = new Meteor.Collection('itineraries')

@Itineraries.before.insert (userId, doc) ->
  doc.created_on = new Date().getTime()

@createItinerary = (attributes = {}) ->
  attributes.title ?= DefaultItinerariesValues().title
  attributes.description ?= DefaultItinerariesValues().description
  Itineraries.insert attributes

Meteor.methods
  clearItineraryElements: (itineraryId) ->
    Elements.remove parentId: itineraryId

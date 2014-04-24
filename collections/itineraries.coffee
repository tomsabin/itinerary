@Itineraries = new Meteor.Collection('itineraries')

@createItinerary = (attributes = {}) ->
  attributes.title ?= DefaultItinerariesValues().title
  attributes.description ?= DefaultItinerariesValues().description
  Itineraries.insert attributes

Handlebars.registerHelper('itinerary', function () {
  return Itinerary.findOne();
});
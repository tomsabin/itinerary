@showOpeners = ->
  $('#openElementButtonContainer').show()
  $('#openCardsContainer').show()
  hideContainers()
@hideContainers = ->
  $('#dateTimeElementsContainer').hide()
  $('#elementButtonContainer').hide()
  $('#cardsContainer').hide()
@openCardsContainer = ->
  $('#openElementButtonContainer').hide()
  $('#openCardsContainer').hide()
  $('#cardsContainer').show()
@openElementsContainer = ->
  $('#openElementButtonContainer').hide()
  $('#openCardsContainer').hide()
  $('#elementButtonContainer').show()
@openDateTimeElementsContainer = ->
  $('#elementButtonContainer').hide()
  $('#dateTimeElementsContainer').show()

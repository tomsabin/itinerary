Template.itineraryElements.events
  focusout: (e) ->
    Elements.update
      _id: e.target.getAttribute("data-element-id")
    ,
      $set:
        body: e.target.innerText
        editable: false

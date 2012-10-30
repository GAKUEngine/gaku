$ ->
  $('#new-class-group form').validationEngine()
  $("#cancel-class-group-link").on 'click', (event)->
    event.preventDefault()
    $('#new-class-group').slideToggle()
    $("#new-class-group-link").show()
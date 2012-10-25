$ ->
  $('#new-student-address form').validationEngine()

  $("#cancel-student-address-link").on 'click', (e)->
    e.preventDefault()
    $("#new-student-address-link").show()
    $("#new-student-address").slideToggle()
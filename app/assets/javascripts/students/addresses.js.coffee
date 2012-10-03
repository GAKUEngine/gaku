$ ->
  $('#new-student-address-form form').validationEngine()

  $('#new-student-address-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#new-student-address-form').slideToggle()

  $("#cancel-student-address-link").click ->
    $("#new-student-address-link").show()
    $("#new-student-address-form").slideToggle()
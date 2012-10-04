$ ->
  $('#new-student-address-form-container form').validationEngine()

  $('#new-student-address-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-student-address-form').slideToggle()

  $("#cancel-student-address-link").click ->
    $("#new-student-address-link").show()
    $("#new-student-address-form").slideToggle()
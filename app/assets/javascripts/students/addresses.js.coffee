$ ->
  $('#new-student-address form').validationEngine()

  $('#new-student-address-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-student-address form').slideToggle()

  $("#cancel-student-address-link").on 'click', (e)->
    e.preventDefault()
    $("#new-student-address-link").show()
    $("#new-student-address form").slideToggle()
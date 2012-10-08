$ ->
  $('#new-student-guardian-address form').validationEngine()

  $('#new-student-guardian-address-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-student-guardian-address form').slideToggle()

  $('#cancel-student-guardian-address-link').click ->
    $('#new-student-guardian-address-link').show()
    $('#new-student-guardian-address form').slideToggle()
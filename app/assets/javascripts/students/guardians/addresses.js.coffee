$ ->
  $('#new-student-guardian-address-form form').validationEngine()

  $('#cancel-student-guardian-address-link').click ->
    $('#new-student-guardian-address-link').show()
    $('#new-student-guardian-address-form').slideToggle()
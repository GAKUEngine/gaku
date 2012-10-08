$ ->
  $('#new-student-guardian-contact form').validationEngine()

  $('#new-student-guardian-contact-link').on 'click', (event)->
    event.preventDefault()
    $('#new-student-guardian-contact-link').hide()
    $('#new-student-guardian-contact form').slideToggle()

  $("#cancel-student-guardian-contact-link").click ->
    $("#new-student-guardian-contact-link").show()
    $("#new-student-guardian-contact form").slideToggle()
$ ->
  $('new-student-contact-form form').validationEngine()

  $('#new-student-contact-link').on 'click', 'a.btn', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-student-contact-form').slideToggle()

  $("#cancel-student-contact-link").click ->
    $("#new-student-contact-link").show()
    $("#new-student-contact-form").slideToggle()
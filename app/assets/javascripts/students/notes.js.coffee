$ ->
  $('#new-student-note-form form').validationEngine()

  $("#submit-student-note-button").live "ajax:success", (data, status, xhr)->
    #add new record to list
    $("#new-student-note-link").show()
    $("#new-student-note-form").slideToggle()

  $("#cancel-student-note-link").click ->
    $("#new-student-note-link").show()
    $("#new-student-note-form").slideToggle()
$ ->
  $('#new-note form').validationEngine()

  $("#submit-student-note-button").live "ajax:success", (data, status, xhr)->
    #add new record to list
    $("#new-student-note-link").show()
    $("#new-student-note form").slideToggle()

  $("#cancel-note-link").click ->
    $("#new-note-link").show()
    $("#new-note").slideToggle()
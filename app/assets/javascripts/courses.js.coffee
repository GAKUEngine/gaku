$ = jQuery

$("#add_student_enrollment").live("ajax:success", (event, data, status, xhr) ->
  $("#add_student_enrollment").append(data)
)

$ ->
  $('#new-student-course-enrollment-form form').validationEngine()

  $("#new-student-course-enrollment-link").click ->
    $("#new-student-course-enrollment-link").hide()
    $("#new-student-course-enrollment-form").slideToggle()

  $("#cancel-student-course-enrollment-link").click ->
    $("#new-student-course-enrollment-form").slideToggle()
    $("#new-student-course-enrollment-link").show()
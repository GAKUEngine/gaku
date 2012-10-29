$ ->
  $('#new-student-course-enrollment form').validationEngine()

	$("#cancel-student-course-enrollment-link").on 'click', (e) ->
		e.preventDefault()
		$("#new-student-course-enrollment").slideToggle()
		$("#new-student-course-enrollment-link").show()
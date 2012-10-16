$ ->
  $('#new-student-note form').validationEngine()

	$("#cancel-student-note-link").on 'click', (e) ->
		e.preventDefault()
		$("#new-student-note-link").show()
		$("#new-student-note").slideToggle()
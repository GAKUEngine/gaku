$ ->
  $('#new-student-contact form').validationEngine()

	$("#cancel-student-contact-link").on 'click', (e) ->
		e.preventDefault()
		$("#new-student-contact-link").show()
		$("#new-student-contact").slideToggle()
$ ->
  $('#new-student-guardian-contact form').validationEngine()

	$("#cancel-student-guardian-contact-link").on 'click', (event)->
		event.preventDefault()
		$("#new-student-guardian-contact-link").show()
		$("#new-student-guardian-contact").slideToggle()
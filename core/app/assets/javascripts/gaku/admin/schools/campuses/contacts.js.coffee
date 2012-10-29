$ ->
	$("#cancel-admin-school-campus-contact-link").on 'click', (event) ->
		event.preventDefault()
		$("#new-admin-school-campus-contact-link").show()
		$("#new-admin-school-campus-contact").slideToggle()
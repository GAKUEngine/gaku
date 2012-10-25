$ ->
	$('#new-admin-enrollment-status-type form').validationEngine()

	$("#cancel-admin-enrollment-status-type-link").on 'click', (event)->
		event.preventDefault()
		$("#new-admin-enrollment-status-type-link").show()
		$("#new-admin-enrollment-status-type").slideToggle()
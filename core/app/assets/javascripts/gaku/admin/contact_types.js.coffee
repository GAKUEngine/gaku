$ ->
	$('#new-admin-contact-type form').validationEngine()

	$('#new-admin-contact-type').on 'click','#cancel-admin-contact-type-link', (event) ->
		event.preventDefault()
		$('#new-admin-contact-type-link').show()
		$("#new-admin-contact-type").slideToggle()
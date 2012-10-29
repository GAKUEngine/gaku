$ ->
  $('#new-admin-school-campus-address form').validationEngine()

	$('#cancel-admin-school-campus-address-link').on 'click', (event) ->
		event.preventDefault()
		$('#new-admin-school-campus-address-link').show()
		$('#new-admin-school-campus-address').slideToggle()
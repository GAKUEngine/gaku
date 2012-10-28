$ ->
  $('#new-student-guardian-address form').validationEngine()

	$('#cancel-student-guardian-address-link').on 'click', (event)->
		event.preventDefault()
		$('#new-student-guardian-address-link').show()
		$('#new-student-guardian-address').slideToggle()
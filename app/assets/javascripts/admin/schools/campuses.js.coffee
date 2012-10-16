$ ->
	$('#cancel-admin-school-campus-link').on 'click', (event) ->
		event.preventDefault()
		$('#new-admin-school-campus-link').show()
		$("#new-admin-school-campus").slideToggle()

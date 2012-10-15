$ ->
	$('#new-admin-school-campus').on 'click','#cancel-admin-school-campus-link', (event) ->
		event.preventDefault()
		$('#new-admin-school-campus-link').show()
		$("#new-admin-school-campus").slideToggle()

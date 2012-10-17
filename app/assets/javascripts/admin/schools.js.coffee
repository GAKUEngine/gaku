$ ->
	$("#cancel-admin-school-link").on 'click', (event)->
		event.preventDefault()
		$("#new-admin-school-link").show()
		$("#new-admin-school").slideToggle()
$ ->
	$('#new-admin-commute-method-type').on 'click','#cancel-admin-commute-method-type-link', (event)->
		event.preventDefault()
		$("#new-admin-commute-method-type-link").show()
		$("#new-admin-commute-method-type").slideToggle()
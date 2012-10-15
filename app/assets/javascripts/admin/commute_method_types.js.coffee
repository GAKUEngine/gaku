$ ->
	$('#new-admin-commute-method-type').on 'click','#cancel-admin-commute-method-type-link', (e)->
		e.preventDefault()
		$("#new-admin-commute-method-type-link").show()
		$("#new-admin-commute-method-type form").slideToggle().html('')
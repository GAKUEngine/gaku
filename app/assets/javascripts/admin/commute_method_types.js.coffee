$ ->
	$('#new-commute-method-type-form').on 'click','#cancel-commute-method-type-link', (e)->
		e.preventDefault()
		$("#new-commute-method-type-link").show()
		$("#new-commute-method-type-form").slideToggle().html('')
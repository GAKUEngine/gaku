$ ->
	$('#new-exam-portion-attachment-link').on 'click', (e)->
		e.preventDefault()
		$('#new-exam-portion-attachment-form').slideToggle()
$ ->
	$('#new-course-group-enrollment-link').on 'click', (e)->
		e.preventDefault()
		$('#course-group-enrollment-form-errors').html ''
		$('#new-course-group-enrollment-form').slideToggle()

	$('#new-course-group-link').on 'click', (e)->
		e.preventDefault()
		$('#course-group-form-errors').html ''
		$('#new-course-group-form').slideToggle()

	$('#cancel-course-group-link').on 'click', (e) ->
		e.preventDefault()
		$('#new-course-group-form').slideToggle()
		$('#course-group-form-errors').html('')

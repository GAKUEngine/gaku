$ ->
	$('#add_course_enrollment_link').on 'click', (e)->
		e.preventDefault()
		$('#course_enrollment_form_errors').html ''
		$('#add_course_enrollment_form form').slideToggle()
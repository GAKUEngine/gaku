$ ->
	$('#add_course_enrollment_link').on 'click', (e)->
		e.preventDefault()
		$('#course_enrollment_form_errors').html ''
		$('#add_course_enrollment_form form').slideToggle()

	$('#add_new_course_group_form form').hide()

	$('#add_new_course_group_button a').on 'click', (e)->
		e.preventDefault()
		$('#course_group_form_errors').html ''
		$('#add_new_course_group_form form').slideToggle()

	$('.course_group_enrollment_delete_link').live 'ajax:success', ->
		$(this).closest('tr').remove()

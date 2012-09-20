$ ->
	$('#add_course_enrollment_link').on 'click', (e)->
		e.preventDefault()
		$('#course_enrollment_form_errors').html ''
		$('#add_course_enrollment_form').slideToggle()

	$('#new_course_group_link').on 'click', (e)->
		e.preventDefault()
		$('#course_group_form_errors').html ''
		$('#add_new_course_group_form').slideToggle()

	$('#cancel_add_course_group_btn').on 'click', (e) ->
		e.preventDefault()
		$('#add_new_course_group_form').slideToggle()
		$('#course_group_form_errors').html('')

	$('.course_group_enrollment_delete_link').live 'ajax:success', ->
		$(this).closest('tr').remove()
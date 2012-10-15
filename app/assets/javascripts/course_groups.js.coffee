$ ->

	$('#cancel-course-group-link').on 'click', (e) ->
		e.preventDefault()
		$('#new-course-group').slideToggle()
		$('#course-group-form-errors').html ''
		$('#new-course-group-link').show()



	$('#new-course-group-enrollment-link').on 'click', (e)->
		e.preventDefault()
		$(this).hide()
		$('#course-group-enrollment-form-errors').html ''
		$('#new-course-group-enrollment form').slideToggle()

  $("#cancel-course-group-enrollment-link").click ->
    $("#new-course-group-enrollment form").slideToggle()
    $("#course-group-enrollment-form-errors").html('')
    $("#new-course-group-enrollment-link").show()
    false    #prevent page from reloading

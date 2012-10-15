$ ->
	$('#new-admin-enrollment-status-type form').validationEngine()

	$('#new-admin-enrollment-status-type-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-admin-enrollment-status-type form').slideToggle()

  $("#cancel-admin-enrollment-status-type-link").click ->
    $("#new-admin-enrollment-status-type-link").show()
    $("#new-admin-enrollment-status-type form").slideToggle()
$ ->
	$('#new-admin-contact-type form').validationEngine()

	$('#new-admin-contact-type-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-admin-contact-type form').slideToggle()

  $("#cancel-admin-contact-type-link").click ->
    $("#new-admin-contact-type-link").show()
    $("#new-admin-contact-type form").slideToggle()
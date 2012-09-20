$ ->
	# works for contacts and address

	$('#new_guardian_contact_link').on 'click', (event)->
		event.preventDefault()
		$('#new_guardian_contact_link').hide()
		$('#new_guardian_contact_form').slideDown()


	$('.make_primary_address').live 'ajax:success', ->
		$('.make_primary_address').each ->
			$(@).removeClass('btn-primary')

		$(@).addClass('btn-primary')

	delete_link = $("#delete-student-guardian-address-link")
	delete_link.live "ajax:success", (evt, data, status, xhr) ->
		$(this).closest('tr').remove()
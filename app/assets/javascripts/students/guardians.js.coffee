$ ->
	$('.delete_link').live 'ajax:success', ->
		$(this).closest('tr').remove()


	$('#new_guardian_contact_link').on 'click', (event)->
		event.preventDefault()
		$('#new_guardian_contact_link').hide()
		$('#new_guardian_contact_form').slideDown()

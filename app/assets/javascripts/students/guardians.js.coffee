$ ->
	# works for contacts and address

	$('#new-student-guardian-contact-link').on 'click', (event)->
		event.preventDefault()
		$('#new-student-guardian-contact-link').hide()
		$('#new-student-guardian-contact-form').slideDown()


	$('.make-primary-address').live 'ajax:success', ->
		$('.make-primary-address').each ->
			$(@).removeClass('btn-primary')

		$(@).addClass('btn-primary')

	$(".delete-student-guardian-address").live "ajax:success", (evt, data, status, xhr) ->
		$(this).closest('tr').remove()
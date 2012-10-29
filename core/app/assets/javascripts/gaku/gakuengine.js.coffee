$ ->
	# small plugin for fadeOut notices after 2sec when notice is showed	
	window.showNotice = (notice)->
		$('#notice').html(notice).delay(3000).fadeOut ->
			$(@).html('').show()
 
  $('.delete-link').live 'ajax:success', (evt, data, status, xhr) ->
    $(this).closest('tr').remove()
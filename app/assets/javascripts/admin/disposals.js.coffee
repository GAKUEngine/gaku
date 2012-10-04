$ ->
	$(document).on 'ajax:success', '.recovery-link', ->
		$(this).closest('tr').remove()
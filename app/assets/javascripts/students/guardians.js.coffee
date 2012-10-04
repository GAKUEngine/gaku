$ ->
	
  $('#new-student-guardian-form form').validationEngine()

  $("#submit-student-guardian-button").live "ajax:success", (data, status, xhr) ->
    $("#new-student-guardian-link").hide()
    $("#new-student-guardian-form").slideToggle()

  $("#cancel-student-guardian-link").click ->
    $("#new-student-guardian-link").show()
    $("#new-student-guardian-form").slideToggle()  

  $(".delete-student-guardian-link").live "ajax:success", (evt, data, status, xhr) ->
    $(this).closest('div.guardian-cell').remove()
	

	$('.make-primary-address').live 'ajax:success', ->
		$('.make-primary-address').each ->
			$(@).removeClass('btn-primary')

		$(@).addClass('btn-primary')
add_guardian = $("#add_guardian_link")
add_guardian.live "ajax:success", (data, status, xhr) ->
  $('#add_guardian_form_area').html(status)
  add_guardian.hide()

$ ->       
  $('.make-primary-address').live 'ajax:success', ->
    $('.make-primary-address').each ->
      $(@).removeClass('btn-primary')
    $(@).addClass('btn-primary')

  $('#student-commute-method').on 'click','#cancel-commute-method-link', (e)->
 		e.preventDefault()
 		if $(@).parent('form').attr('class') == 'new_commute_method'
	 		$('#student-commute-method-form').html('')
	 		$('#new-student-commute-method-link').show()
 		else
	 		$('span#commute-method').show()
	 		$('#edit-student-commute-method-link').show()
	 		$('#student-commute-method-form').html('')


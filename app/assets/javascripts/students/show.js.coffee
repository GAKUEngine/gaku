add_guardian = $("#add_guardian_link")
add_guardian.live "ajax:success", (data, status, xhr) ->
  $('#add_guardian_form_area').html(status)
  add_guardian.hide()

$ ->       
  $(".delete-student-guardian-link").live "ajax:success", (evt, data, status, xhr) ->
    $(this).closest('div.guardian-cell').remove()

  #$("#new-student-note-link").live "ajax:success", (date, status, xhr) ->
  #  $('#new-student-note-form').html(status)
  #  $("#new-student-note-link").hide()

  #$('#new-student-course-enrollment-link').on 'click','a.btn', (event) ->
  #  event.preventDefault()
  #  $('#new-student-course-enrollment-form').slideToggle()

  $('#new-student-contact-link').on 'click', 'a.btn', (event) ->
	  event.preventDefault()
	  $(this).hide()
	  $('#new-student-contact-form').slideDown()

  $('.make-primary-address').live 'ajax:success', ->
    $('.make-primary-address').each ->
      $(@).removeClass('btn-primary')
    $(@).addClass('btn-primary')
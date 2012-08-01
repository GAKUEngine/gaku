addGuardian = $("#add_guardian_link")
addGuardian.live("ajax:success", (data, status, xhr)->
  $('#add_guardian_form_area').html(status)
  addGuardian.hide()
)

addNote = $("#add_note_link")
addNote.live("ajax:success", (date, status, xhr)->
  $('#add_note_form_area').html(status)
  addNote.hide()
)

$ ->
	$('#add_course_enrollment').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#course_form').slideToggle()
      

deleteLink= $(".delete_link")
deleteLink.live("ajax:success", (evt, data, status, xhr) ->
    $(this).closest('tr').fadeOut();
)

$('.new_student_contact_form').hide()

$('#add_new_student_contact').on 'click', 'a.btn', (event) ->
	event.preventDefault()
	$(this).hide()
	$('.new_student_contact_form').slideDown()


$('.make_primary_address').live 'ajax:success', ->
  $('.primary_address').each ->
    $(@).html('')

  $('.make_primary_address').each ->
     $(@).removeClass('btn-primary')

  $(@).closest('tr').find('.primary_address').html('Primary')

  $(@).addClass('btn-primary')
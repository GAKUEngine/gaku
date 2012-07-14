addGuardian = $("#add_guardian_link")
addGuardian.live("ajax:success", (data, status, xhr)->
  $('#add_guardian_form_area').html(status)
  addGuardian.hide()
)
  
$ ->
	$('#add_course_enrollment').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#course_form').slideToggle()

addGuardian = $("#add_guardian_link")
addGuardian.live("ajax:success", (data, status, xhr)->
  $('#add_guardian_form_area').html(status)
  addGuardian.hide()
)

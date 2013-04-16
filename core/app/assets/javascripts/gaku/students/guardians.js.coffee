$ ->
  $("#submit-student-guardian-button").live "ajax:success", (data, status, xhr) ->
    $("#new-student-guardian-link").hide()
    $("#new-student-guardian form").slide()

  $(".delete-student-guardian-link").live "ajax:success", (evt, data, status, xhr) ->
    $(this).closest('div.guardian-cell').remove()

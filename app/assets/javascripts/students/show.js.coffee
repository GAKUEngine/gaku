add_guardian = $("#add_guardian_link")
add_guardian.live "ajax:success", (data, status, xhr) ->
  $('#add_guardian_form_area').html(status)
  add_guardian.hide()

$ ->       
  $('.make-primary-address').live 'ajax:success', ->
    $('.make-primary-address').each ->
      $(@).removeClass('btn-primary')
    $(@).addClass('btn-primary')
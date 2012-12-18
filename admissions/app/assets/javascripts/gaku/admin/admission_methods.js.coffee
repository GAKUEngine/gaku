$ ->
  
  $('#new-admin-admission-method').on 'click','#cancel-admin-admission-method-link', (event) ->
    event.preventDefault()
    $('#new-admin-admission-method-link').show()
    $("#new-admin-admission-method").slideToggle()

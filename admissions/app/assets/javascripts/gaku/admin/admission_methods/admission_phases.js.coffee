$ ->
  
  $('#new-admin-admission-methodadmission-phase').on 'click','#cancel-admin-admission-method-admission-phase-link', (event) ->
    event.preventDefault()
    $('#new-admin-admission-method-admission-phase-link').show()
    $("#new-admin-admission-method-admission-phase").slideToggle()

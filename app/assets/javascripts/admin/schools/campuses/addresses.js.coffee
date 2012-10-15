$ ->
  $('#new-admin-school-campus-address form').validationEngine()

  $('#new-admin-school-campus-address-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-admin-school-campus-address form').slideToggle()

  $('#cancel-admin-school-campus-address-link').click ->
    $('#new-admin-school-campus-address-link').show()
    $('#new-admin-school-campus-address form').slideToggle()
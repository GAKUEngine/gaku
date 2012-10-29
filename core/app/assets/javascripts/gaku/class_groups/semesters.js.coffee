$ ->
  $("#cancel-class-group-semester-link").on 'click', (event)->
    event.preventDefault()
    $("#new-class-group-semester-link").show()
    $("#new-class-group-semester").slideToggle()
    $("#semester-modal").modal("hide")
    $('#new-class-group-semester-form-errors').html('')
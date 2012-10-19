$ ->
  $('#new-class-group form').validationEngine()
    
  $("#cancel-class-group-link").on 'click', (event)->
    event.preventDefault()
    $('#new-class-group').slideToggle()
    $("#new-class-group-link").show()

  $("#cancel-class-group-course-link").on 'click', (e)->
    event.preventDefault()
    $("#new-class-group-course-link").show()
    $("#new-class-group-course").slideToggle()

  $("#cancel-class-group-semester-link").on 'click', (event)->
    event.preventDefault()
    $("#new-class-group-semester-link").show()
    $("#new-class-group-semester").slideToggle()
    $("#semester-modal").modal("hide")

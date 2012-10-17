$ ->
  $('#new-class-group form').validationEngine()
    
  $("#cancel-class-group-link").on 'click', (event)->
    event.preventDefault()
    $('#new-class-group').slideToggle()
    $("#new-class-group-link").show()

  $("#cancel-course-link").click ->
    $("#new-class-group-course-link").show()
    $("#new-class-group-course form").slideToggle()
    false    #prevent page from reloading

  $("#cancel-class-group-semester-link").on 'click', (event)->
    event.preventDefault()
    $("#new-class-group-semester-link").show()
    $("#new-class-group-semester").slideToggle()
    $("#semester-modal").modal("hide")

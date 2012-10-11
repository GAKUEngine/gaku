$ ->
  $('#new-class-group-link').on 'click', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-class-group form').slideToggle()

  $('#new-class-group form').validationEngine()
    
  $("#cancel-class-group-link").click ->
    $('#new-class-group form').slideToggle()
    $("#new-class-group-link").show()

  $("#cancel-course-link").click ->
    $("#new-class-group-course-link").show()
    $("#new-class-group-course form").slideToggle()
    false    #prevent page from reloading

  $('#new-class-group-semester-link').on 'click', (event) ->
    event.preventDefault()
    $(this).hide()
    $('#new-class-group-semester form').slideToggle()

  $("#cancel-class-group-semester-link").click ->
    $("#new-class-group-semester-link").show()
    $("#new-class-group-semester form").slideToggle()
    $("#semester-modal").modal("hide")
    false    #prevent page from reloading

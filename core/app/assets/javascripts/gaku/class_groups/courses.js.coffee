$ ->
  $("#cancel-class-group-course-link").on 'click', (e)->
    event.preventDefault()
    $("#new-class-group-course-link").show()
    $("#new-class-group-course").slideToggle()
$ ->

  $('#new-class-group-link').on 'click', (event) ->
  	event.preventDefault()
  	$('#new-class-group').slideToggle()

  $("#cancel-class-group-link").click ->
    $('#new-class-group').slideToggle()

  $("#cancel-course-link").click ->
    $("#new-class-group-course-link").show()
    $("#new-class-group-course-form").html('')
    false    #prevent page from reloading

  $("#cancel-semester-link").click ->
    $("#new-class-group-semester-link").show()
    $("#new-class-group-semester-form").html("")
    $("#semester-modal").modal("hide")
    false    #prevent page from reloading

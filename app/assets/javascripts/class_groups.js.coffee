$ ->

  $('#new-class-group-link').on 'click', (event) ->
  	event.preventDefault()
  	$('#new-class_group').slideToggle()

  $("#cancel-class_group-link").click ->
    $('#new-class_group').slideToggle()

  $("#cancel-course-link").click ->
    $("#new-class-group-course-link").show()
    $("#new-class-group-course-form").html('')
    false    #prevent page from reloading

  $("#cancel-semester-link").click ->
    $("#new-class-group-semester-link").show()
    $("#new-class-group-semester-form").html("")
    $("#semester-modal").modal("hide")
    false    #prevent page from reloading

  deleteLink= $(".delete_link")
  deleteLink.live "ajax:success", (evt, data, status, xhr) ->
    $(this).closest('tr').remove()

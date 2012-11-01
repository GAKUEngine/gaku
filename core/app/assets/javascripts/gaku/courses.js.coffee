root = exports ? this
$ = jQuery

class CourseActions
  enrollmentForm: null
  enrollments: null

  constructor: () ->

  hookupEnrollment: () ->
    @enrollmentForm = $("#add_student_enrollment_box")
    @enrollments = []

    #attach ajax to enrollment form
    $("#add_student_enrollment").on "ajax:complete", (event, data, status) =>
      @enrollmentForm = $("#add_student_enrollment_box")
      @enrollmentForm.append(data.responseText)

@CourseAct = new CourseActions()

$ ->

  $('#new-course form').validationEngine()
    
  $("#new-course").on 'click',"#cancel-course-link", (event)->
    event.preventDefault()
    $('#new-course').slideToggle()
    $('#new-course-link').show()

  $('#new-course-class-group-link').on 'click', (event)->
    event.preventDefault()
    $('#new-course-student-form').hide()
    $('#new-course-student-link').show()
    $('#new-course-class-group-link').hide()
    $('#new-course-class-group').slideToggle()

  $("#cancel-course-student-link").click ->
    $("#new-course-student-link").show()
    $("#new-course-student-form").html("")

  $("#cancel-course-class-group-link").click ->
    $("#new-course-class-group-link").show()
    $("#new-course-class-group").slideToggle()
    $("#new-course-class-group-form-errors").html("");
      
  # $(".chzn-select").chosen()

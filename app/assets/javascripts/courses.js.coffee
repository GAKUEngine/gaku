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
  $('#new-course-student-link').on 'click', (event)->
    event.preventDefault()
    $('#new-course-class-group-form').hide()
    $('#new-course-class-group-link').show()
    $('#new-course-student-link').hide()
    $('#new-course-student-form').slideToggle()


  $('#new-course-class-group-link').on 'click', (event)->
    event.preventDefault()
    $('#new-course-student-form').hide()
    $('#new-course-student-link').show()
    $('#new-course-class-group-link').hide()
    $('#new-course-class-group-form').slideToggle()

  $(".chzn-select").chosen()

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
    $("#add_student_enrollment").on("ajax:complete", (event, data, status) =>
      @enrollmentForm = $("#add_student_enrollment_box")

      @enrollmentForm.append(data.responseText)
    )


@CourseAct = new CourseActions()

$ ->
  $('#add_student_enrollment_link').on 'click','a.make-button', (event)->
    event.preventDefault()
    $('#add_student_enrollment_form').slideToggle()

  $('#class_group_enrollment').on 'click', 'a.show_class_enroll_form', ->
    event.preventDefault()
    $('#class_group_enrollment form').slideToggle()

  $(".chzn-select").chosen()


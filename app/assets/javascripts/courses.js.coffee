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


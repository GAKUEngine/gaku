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
    $("#add_student_enrollment").on("ajax:complete", (event, data, status, xhr) =>
      alert "fire"
      @enrollmentForm = $("#add_student_enrollment_box")
      ne = $(data)

      @enrollments.push(ne)
      @enrollmentForm.append(@enrollments[@enrollments.length - 1])

     #@enrollmentForm.append("event:" + event + "\ndata: " + data + "\nstatus: " + status + "\nxhr: " + xhr)
     #alert data.id
     #@enrollmentForm.append(event)
    )


@CourseAct = new CourseActions()


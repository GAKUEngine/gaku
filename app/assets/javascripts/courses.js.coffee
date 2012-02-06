$ = jQuery

class CourseActions
  enrollmentForm: null
  enrollments: null

  constructor: () ->
  @enrollmentForm = $("#add_student_enrollment")
  @enrollments = []
  
  #attach ajax to enrollment form
  @enrollmentForm.live("ajax:success", (event, data, status, xhr) =>
    @enrollmentForm = $("#add_student_enrollment")
    ne = $(data)

    @enrollments.push(ne)
    @enrollmentForm.append(@enrollments[@enrollments.length - 1])

    #@enrollmentForm.append("event:" + event + "\ndata: " + data + "\nstatus: " + status + "\nxhr: " + xhr)
    #alert data.id
    #@enrollmentForm.append(event)
  )

CourseAct = CourseActions()

ready = ->

  self = this

  class CoursesController
    edit: ->
      self.app.student_chooser()

    grading: ->

      socket = io.connect("http://localhost:5001")

      socket.on "grading-change", (message) ->
        exam_id   = message.exam_id
        course_id = message.course_id
        if message.exam_portion_score
          exam_portion_score = message.exam_portion_score.exam_portion_score
          form = $("#edit_exam_portion_score_#{exam_portion_score.id}")
          input = form.children('input#exam_portion_score_score')
          input.val("#{exam_portion_score.score}")
        for grading_method_id, calculation of message.calculations
          if calculation.student_results
            console.log('vika me collection')
            for result in calculation.student_results
              el = $("#course-#{course_id}-exam-#{exam_id}-student-#{result.id}-grading-method-#{grading_method_id}-score")
              el.html result.score

          else
            console.log('vika me single')
            el = $("#course-#{course_id}-exam-#{exam_id}-student-#{calculation.id}-grading-method-#{grading_method_id}-score")
            el.html calculation.score

  @app.courses = new CoursesController

$(document).ready(ready)
$(document).on('page:load', ready)

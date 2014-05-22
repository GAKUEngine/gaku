ready = ->

  self = this

  class CoursesController
    edit: ->
      self.app.student_chooser()

    grading: ->

      socket = io.connect("http://localhost:5001")

      socket.on "grading-change", (message) ->

        if message.exam_portion_score
          exam_portion_score = message.exam_portion_score
          form = $("#edit_exam_portion_score_#{exam_portion_score.id}")
          input = form.children('input#exam_portion_score_score')
          input.val("#{exam_portion_score.score}")

        student_id = message.score.student_results[0].id
        score = message.score.student_results[0].score

        $("#student-#{student_id}-score").html(score)

  @app.courses = new CoursesController

$(document).ready(ready)
$(document).on('page:load', ready)

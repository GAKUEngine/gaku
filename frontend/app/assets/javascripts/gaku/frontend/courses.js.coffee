ready = ->

  self = this

  class CoursesController
    edit: ->
      self.app.student_chooser()

    grading: ->
      $(document).on 'change', '#exam_portion_score_score_selection', (e)->
        $(@).parent('form').submit()



      socket = io.connect("http://localhost:5001")

      socket.on "grading-change", (message) ->
        exam_id   = message.exam_id
        gradable_id = message.gradable_id
        gradable_type = message.gradable_type
        exam_portion_score = message.exam_portion_score.exam_portion_score
        form = $("#edit_exam_portion_score_#{exam_portion_score.id}")

        if message.exam_portion_score
          switch message.exam_portion_score_type
            when 'score_text'
              input = form.children('input#exam_portion_score_score_text')
              input.val("#{exam_portion_score.score_text}")
            when 'score'
              input = form.children('input#exam_portion_score_score')
              input.val("#{exam_portion_score.score}")
            when 'score_selection'
              input = form.children('select#exam_portion_score_score_selection')
              console.log form
              input.val("#{exam_portion_score.score_selection}")

            else null


        for grading_method_id, calculation of message.calculations
          if calculation.student_results
            for result in calculation.student_results
              el = $("##{gradable_type}-#{gradable_id}-exam-#{exam_id}-student-#{result.id}-grading-method-#{grading_method_id}-score")
              el.html result.score

          else
            el = $("##{gradable_type}-#{gradable_id}-exam-#{exam_id}-student-#{calculation.id}-grading-method-#{grading_method_id}-score")
            el.html calculation.score

  @app.courses = new CoursesController

$(document).ready(ready)
$(document).on('page:load', ready)

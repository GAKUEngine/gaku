ready = ->

  self = this

  class CoursesController
    edit: ->
      self.app.student_chooser()

    # grading: ->
    #   source = new EventSource '/realtime/exam_portion_scores'
    #   source.addEventListener 'update.examPortionScore', (event)->
    #     console.log event.data
    #     json = $.parseJSON(event.data)

    #     form = $("#edit_exam_portion_score_#{json.exam_portion_score.id}")
    #     input = form.children('input#exam_portion_score_score')

    #     input.val("#{json.exam_portion_score.score}")

  @app.courses = new CoursesController

$(document).ready(ready)
$(document).on('page:load', ready)

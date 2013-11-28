ready = ->

  self = this

  class CoursesController
    edit: ->
      self.app.student_chooser()

    grading: ->
      $('.edit_exam_portion_score').find('input').on 'blur', ->
        $(@).parent().submit()

      faye = new Faye.Client 'http://localhost:9292/faye'
      faye.subscribe '/messages/new', (data) ->
          eval(data)

  @app.courses = new CoursesController

$(document).ready(ready)
$(document).on('page:load', ready)

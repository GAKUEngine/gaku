ready = ->

  self = this

  class CoursesController
    edit: ->
      self.app.student_chooser()

  @app.courses = new CoursesController

$(document).ready(ready)
$(document).on('page:load', ready)

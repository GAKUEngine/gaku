ready = ->

  self = this

  class ExtracurricularActivitiesController
    edit: ->
      self.app.student_chooser()

  @app.extracurricular_activities = new ExtracurricularActivitiesController

$(document).ready(ready)
$(document).on('page:load', ready)

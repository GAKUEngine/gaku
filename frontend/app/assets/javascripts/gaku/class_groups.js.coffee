ready = ->
  self = this

  class ClassGroupsController
    edit: ->
      self.app.student_chooser()

  @app.class_groups = new ClassGroupsController

$(document).ready(ready)
$(document).on('page:load', ready)

ready = ->

  self = this

  class TeachersController
    edit: ->
      self.app.country_dropdown()

  @app.teachers = new TeachersController

$(document).ready(ready)
$(document).on('page:load', ready)

ready = ->

  self = this

  class TeachersController
    edit: ->
      self.app.country_dropdown()
      self.app.upload_picture_ajax()


  @app.teachers = new TeachersController

$(document).ready(ready)
$(document).on('page:load', ready)

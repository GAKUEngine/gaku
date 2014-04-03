ready = ->

  self = this

  class GuardiansController

    edit: ->
      self.app.country_dropdown()
      self.app.upload_picture_ajax()

  @app.guardians = new GuardiansController

$(document).ready(ready)
$(document).on('page:load', ready)

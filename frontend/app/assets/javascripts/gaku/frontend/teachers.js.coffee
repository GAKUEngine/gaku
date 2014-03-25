ready = ->

  self = this

  class TeachersController
    edit: ->
      self.app.country_dropdown()

      $('.picture-upload').popover
        html: true
        content: $('#upload-picture')[0].innerHTML
        placement: 'bottom'
        trigger: 'click'

  @app.teachers = new TeachersController

$(document).ready(ready)
$(document).on('page:load', ready)

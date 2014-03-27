ready = ->

  self = this

  class TeachersController
    edit: ->
      self.app.country_dropdown()

      $('body').popover
        selector: '.picture-upload'
        html: true
        content: ()->
          return $('#upload-picture').html()
        placement: 'bottom'
        trigger: 'click'


  @app.teachers = new TeachersController

$(document).ready(ready)
$(document).on('page:load', ready)

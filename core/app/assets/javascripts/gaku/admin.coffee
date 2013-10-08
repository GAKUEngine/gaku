ready = ->
  self = this

  class AdminController
    init: ->
      #need to add datepicker to newly added inputs from nested_form_for
      $('body').on 'click','.add-semester', ->
        setTimeout ->
          $('.datepicker').datepicker()
        ,500

    index: ->
      self.app.upload_picture()

    edit: ->
      self.app.country_dropdown()

    show: ->
      self.app.country_dropdown()

    new: ->
      self.app.country_dropdown()

    school_details: ->
      self.app.upload_picture()

  @app.admin = new AdminController

$(document).ready(ready)
$(document).on('page:load', ready)

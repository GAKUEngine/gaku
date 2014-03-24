ready = ->
  self = this

  class AdminController
    init: ->
      #need to add datepicker to newly added inputs from nested_form_for
      $('body').on 'click','.add-semester', ->
        setTimeout ->
          $('.datepicker').datepicker_i18n()
        ,500

    index: ->
      self.admin.upload_picture()
      $(document).on 'keyup', '.dynamicAttributeName', ->
        nameElem = $(@)
        valueElem = nameElem.closest('.row')
                            .find('.dynamicAttributeValue')
        value = nameElem.val()

        valueElem.attr 'id', "grading_method_criteria_#{value}"
        valueElem.attr 'name', "grading_method[criteria][#{value}]"

      $(document).on 'click', '.remove-criteria-row', (e)->
        e.preventDefault()
        if confirm('Are you sure?')
          $(@).closest('.row').html ''

      $(document).on 'click', '.add-criteria-row', (e)->
        e.preventDefault()

        contents = "<div class='row'> #{$('.attribute-template').html()} </div>"
        $(@).before(contents);


    edit: ->
      self.admin.country_dropdown()

    edit_master: ->
      self.admin.upload_picture()

    new: ->
      self.admin.country_dropdown()

    school_details: ->
      self.admin.upload_picture()

  @admin.admin = new AdminController

$(document).ready(ready)
$(document).on('page:load', ready)

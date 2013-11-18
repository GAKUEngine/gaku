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
      $(document).on 'keyup', '.dynamicAttributeName', ->
        nameElem = $(@)
        valueElem = nameElem.closest('.row')
                            .find('.dynamicAttributeValue')
        value = nameElem.val()

        valueElem.attr 'id', "grading_method_arguments_#{value}"
        valueElem.attr 'name', "grading_method[arguments][#{value}]"
        valueElem.attr 'placeholder', "value for #{value}"

        console.log valueElem

      $(document).on 'click', '.remove-argument-row', (e)->
        e.preventDefault()
        if confirm('Are you sure?')
          $(@).closest('.row').html ''

      $(document).on 'click', '.add-argument-row', (e)->
        e.preventDefault()

        contents = "<div class='row'> #{$('.attribute-template').html()} </div>"
        $(@).before(contents);



# valueElem.attr('id',          'product_data_' + value       );
#      valueElem.attr('name',        'product[data][' + value + ']');
#      valueElem.attr('placeholder', 'value for ' + value          );

    edit: ->
      self.app.country_dropdown()

    edit_master: ->
      self.app.upload_picture()

    new: ->
      self.app.country_dropdown()

    school_details: ->
      self.app.upload_picture()

  @app.admin = new AdminController

$(document).ready(ready)
$(document).on('page:load', ready)

ready = ->
  #need to add datepicker to newly added inputs from nested_form_for
  $('body').on 'click','.add-semester', ->
    setTimeout ->
      $('.datepicker').datepicker()
    ,500

$(document).ready(ready)
$(document).on('page:load', ready)
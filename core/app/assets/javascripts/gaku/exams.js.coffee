ready = ->
  $('.exam-portion-weight').on 'change', ->
    $(@).parent('form').submit()

# $(document).ready ->
#   $(document).on 'click','#exam_use_weighting', ->
#     if $(@).is ':checked'
#       $('#exam_weight').attr 'class','validate[required, custom[integer]min[0]] span12'
#     else
#       $('#exam_weight').attr 'class','span12'
#       $('.exam_weightformError').remove()

$(document).ready(ready)
$(document).on('page:load', ready)
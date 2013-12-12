ready = ->

  class ExamsController
    init: ->
      $('.exam-portion-weight').on 'change', ->
        $(@).parent('form').submit()

      $('#new-exam-portion-attachment-link').on 'click', (e)->
        e.preventDefault()
        $('#new-exam-portion-attachment-form').slide()

      # $(document).ready ->
      #   $(document).on 'click','#exam_use_weighting', ->
      #     if $(@).is ':checked'
      #       $('#exam_weight').attr 'class','validate[required, custom[integer]min[0]] span12'
      #     else
      #       $('#exam_weight').attr 'class','span12'
      #       $('.exam_weightformError').remove()

  @app.exams = new ExamsController

$(document).ready(ready)
$(document).on('page:load', ready)
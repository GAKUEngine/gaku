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
    edit: ->
      $('.datetimepicker').datetimepicker()
    grading: ->
      socket = io.connect("http://localhost:5001")

      socket.on "grading-change", (message) ->
        exam_id   = message.exam_id
        gradable_id = message.gradable_id
        gradable_type = message.gradable_type
        console.log message
        
        if message.exam_portion_score
          exam_portion_score = message.exam_portion_score.exam_portion_score
          form = $("#edit_exam_portion_score_#{exam_portion_score.id}")
          input = form.children('input#exam_portion_score_score')
          input.val("#{exam_portion_score.score}")
        for grading_method_id, calculation of message.calculations
          if calculation.student_results
            for result in calculation.student_results
              el = $("##{gradable_type}-#{gradable_id}-exam-#{exam_id}-student-#{result.id}-grading-method-#{grading_method_id}-score")
              el.html result.score

          else
            el = $("##{gradable_type}-#{gradable_id}-exam-#{exam_id}-student-#{calculation.id}-grading-method-#{grading_method_id}-score")
            console.log el
            el.html calculation.score


  @app.exams = new ExamsController

$(document).ready(ready)
$(document).on('page:load', ready)

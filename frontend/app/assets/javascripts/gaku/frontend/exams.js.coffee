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
      $(document).on 'change', '#exam_portion_score_type', (e)->
        selectValue = $(@).val()
        if selectValue == 'score_selection'
          $('#score_selection_options').removeClass('hide')
        else
          $('#score_selection_options').addClass('hide')


      $(document).on 'click', '.remove-option-row', (e)->
        e.preventDefault()
        if confirm('Are you sure?')
          $(@).closest('.row').html ''

      $(document).on 'click', '.add-option-row', (e)->
        e.preventDefault()
        container = $('.attributeContainer')

        contents = "<div class='row'> #{$('.options-template').html()} </div>"

        container.append(contents)
        container.find('input:last').attr('name', 'exam_portion[score_selection_options][]')


    grading: ->
      $(document).on 'change', '#exam_portion_score_score_selection', (e)->
        $(@).parent('form').submit()



      socket = io.connect("http://localhost:5001")

      socket.on "grading-change", (message) ->
        exam_id   = message.exam_id
        gradable_id = message.gradable_id
        gradable_type = message.gradable_type
        exam_portion_score = message.exam_portion_score.exam_portion_score
        form = $("#edit_exam_portion_score_#{exam_portion_score.id}")

        if message.exam_portion_score
          switch message.exam_portion_score_type
            when 'score_text'
              input = form.children('input#exam_portion_score_score_text')
              input.val("#{exam_portion_score.score_text}")
            when 'score'
              input = form.children('input#exam_portion_score_score')
              input.val("#{exam_portion_score.score}")
            when 'score_selection'
              input = form.children('select#exam_portion_score_score_selection')
              console.log form
              input.val("#{exam_portion_score.score_selection}")

            else null


        for grading_method_id, calculation of message.calculations
          if calculation.student_results
            for result in calculation.student_results
              el = $("##{gradable_type}-#{gradable_id}-exam-#{exam_id}-student-#{result.id}-grading-method-#{grading_method_id}-score")
              el.html result.score

          else
            el = $("##{gradable_type}-#{gradable_id}-exam-#{exam_id}-student-#{calculation.id}-grading-method-#{grading_method_id}-score")
            el.html calculation.score


  @app.exams = new ExamsController

$(document).ready(ready)
$(document).on('page:load', ready)

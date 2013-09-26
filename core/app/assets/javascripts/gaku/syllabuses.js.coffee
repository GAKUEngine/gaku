ready = ->

  class SyllabusesController
    init: ->
      $('#syllabus-exams').on "click", '#new-syllabus-exam-link', (event) ->
        event.preventDefault()
        #$(@).hide()
        $('#new-existing-exam').slideUp ->
          #$('#new-syllabus-exam').slide()
          $('#new-existing-exam-link').show()

      $('#syllabus-exams').on "click", '#new-existing-exam-link', (event) ->
        event.preventDefault()
        $(@).hide()
        $('#new-syllabus-exam').slideUp ->
          $('#new-existing-exam').slide()
          $('#new-syllabus-exam-link').show()

      $('#new-syllabus-assignment').on 'click', (event) ->
        event.preventDefault()
        $('#new-syllabus-assignment-form').slide()

  @app.syllabuses = new SyllabusesController

$(document).ready(ready)
$(document).on('page:load', ready)
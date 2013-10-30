ready = ->

  class SyllabusesController
    edit: ->
      $('#syllabus-exams').on "click", '#new-syllabus-exam-link', (event) ->
        console.log 'new-syllabus-exam-link clicked'
        event.preventDefault()
        #$(@).hide()
        $('#new-existing-exam').slideUp ->
          #$('#new-syllabus-exam').slide()
          $('#new-existing-exam-link').show()

      $('#syllabus-exams').on "click", '#new-existing-exam-link', (event) ->
        console.log 'new-existing-exam-link clicked'
        event.preventDefault()
        $(@).hide()
        $('#new-syllabus-exam').slideUp ->
          $('#new-existing-exam').slide()
          $('#new-syllabus-exam-link').show()


  @app.syllabuses = new SyllabusesController

$(document).ready(ready)
$(document).on('page:load', ready)
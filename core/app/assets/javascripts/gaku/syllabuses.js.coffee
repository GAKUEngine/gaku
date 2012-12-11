# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#syllabus-exams').on "click", '#new-syllabus-exam-link', (event) ->
    event.preventDefault()
    $(@).hide()
    $('#new-existing-exam').slideUp ->
      $('#new-syllabus-exam').slideToggle()
      $('#new-existing-exam-link').show()

  $('#syllabus-exams').on "click", '#new-existing-exam-link', (event) ->
    event.preventDefault()
    $(@).hide()
    $('#new-syllabus-exam').slideUp ->
      $('#new-existing-exam').slideToggle()
      $('#new-syllabus-exam-link').show()

  $('#new-syllabus-assignment').on 'click', (event) ->
    event.preventDefault()
    $('#new-syllabus-assignment-form').slideToggle()


  #$('#new-syllabus-exam form').validationEngine()

  #$('#new-syllabus form').validationEngine()

  $('#cancel-syllabus-link').on 'click', (e) ->
    $('#new-syllabus').slideToggle()
    $('#new-syllabus-link').show()


  $('#syllabus-exams').on "click", '#cancel-existing-exam-link', (event)->
    event.preventDefault()
    $('#new-existing-exam').slideToggle()
    $('#new-existing-exam-link').show()

  $('#syllabus-exams').on "click",'#cancel-syllabus-exam-link', (event) ->
    event.preventDefault()
    $('#new-syllabus-exam').slideToggle()
    $('#new-syllabus-exam-link').show()

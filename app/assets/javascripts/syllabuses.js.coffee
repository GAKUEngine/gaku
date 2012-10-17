# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#new-syllabus-exam-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-syllabus-exam-form').slideToggle()

  $('#new-syllabus-assignment').on 'click', (event) ->
    event.preventDefault()
    $('#new-syllabus-assignment-form').slideToggle()

  $('#add-existing-exam-link').on 'click', (event) ->
    event.preventDefault()
    $('#add-existing-exam-form').slideToggle()

  $('#new-syllabus-exam-form form').validationEngine()

  $('#new-syllabus form').validationEngine()

  $('#new-syllabus-link').click (e)->
    e.preventDefault()
    $('#new-syllabus-link').hide()
    $('#new-syllabus').slideToggle()
  
  $('#cancel-syllabus-link').on 'click', (event)->
    event.preventDefault()
    $('#new-syllabus').slideToggle()
    $('#new-syllabus-link').show()
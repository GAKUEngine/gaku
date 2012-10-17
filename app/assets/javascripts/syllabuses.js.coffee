# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#new-syllabus-exam-link').on 'click', (event) ->
    event.preventDefault()
    $(@).hide()
    $('#add-existing-exam').slideUp ->
      $('#new-syllabus-exam').slideToggle() 
      $('#add-existing-exam-link').show()

  $('#add-existing-exam-link').on 'click', (event) ->
    event.preventDefault()
    $(@).hide()
    $('#new-syllabus-exam').slideUp ->
      $('#add-existing-exam').slideToggle()
      $('#new-syllabus-exam-link').show()
  
  $('#new-syllabus-assignment').on 'click', (event) ->
    event.preventDefault()
    $('#new-syllabus-assignment-form').slideToggle()


  $('#new-syllabus-exam form').validationEngine()

  $('#new-syllabus form').validationEngine()

  $('#new-syllabus-link').click (e)->
    e.preventDefault()
    $(@).hide()
    $('#new-syllabus').slideToggle()
    
  
  $('#cancel-syllabus-link').on 'click', (event)->
    event.preventDefault()
    $('#new-syllabus').slideToggle()
    $('#new-syllabus-link').show()

  $('#cancel-exam-syllabus-link').on 'click', (event)->
    event.preventDefault()
    $('#add-existing-exam').slideToggle()
    $('#add-existing-exam-link').show()

  $('#cancel-new-exam-syllabus-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-syllabus-exam').slideToggle()
    $('#new-syllabus-exam-link').show()
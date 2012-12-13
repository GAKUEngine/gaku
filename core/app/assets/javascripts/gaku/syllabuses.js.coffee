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
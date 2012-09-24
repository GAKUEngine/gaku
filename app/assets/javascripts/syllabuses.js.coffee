# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#new-syllabus-exam').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#new-syllabus-exam-form').slideToggle()
      
	$('#new-syllabus-assignment').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#new-syllabus-assignment-form').slideToggle()
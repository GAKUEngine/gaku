# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#add_student_enrollment').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#enrollment_form').slideToggle()


  $('#new_class_group_link').on 'click', (event) ->
  	event.preventDefault()
  	$('#new_class_group_form').slideToggle()
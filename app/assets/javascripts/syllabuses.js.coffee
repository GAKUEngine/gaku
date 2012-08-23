# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#new_syllabus_exam').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#syllabus_exam_form').slideToggle()
      
$ ->
	$('#new_assignment').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#syllabus_assignment_form').slideToggle()

  $('.delete_syllabus').live 'ajax:success', (evt, data, status, xhr) ->
 		$(this).closest('tr').remove();
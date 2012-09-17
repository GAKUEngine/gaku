# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#add_new_student_address').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#new_address_form').slideDown()

  $('#new_student_link').on 'click', (event) ->
  	event.preventDefault()
  	$('#new_student_form').slideToggle()
  	  
  $('.delete_student').live 'ajax:success', (evt, data, status, xhr) ->
	  $(this).closest('tr').remove();
	    


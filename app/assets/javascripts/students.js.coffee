# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#add_new_student_address').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#new_address_form').slideDown()
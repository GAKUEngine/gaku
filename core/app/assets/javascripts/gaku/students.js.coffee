# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  #student show
  $('.make-primary-address').on 'ajax:success', ->
    $('.make-primary-address').each ->
      $(@).removeClass('btn-primary')
    $(@).addClass('btn-primary')

  $('#student-commute-method').on 'click','#cancel-commute-method-link', (e)->
    e.preventDefault()
    if $(@).parent('form').attr('class') == 'new_commute_method'
      $('#student-commute-method-form').html('')
      $('#new-student-commute-method-link').show()
    else
      $('span#commute-method').show()
      $('#edit-student-commute-method-link').show()
      $('#student-commute-method-form').html('')

  $('#student-enrollment-status').on 'click', '#cancel-enrollment-status-link', (event) ->
    event.preventDefault()
    $('#enrolled-status').show()
    $('#edit-student-enrollment-status-link').show()
    $('#student-enrollment-status-form').html('')

  #student

  $('#cancel-student-link').on 'click', (e) ->
    $('#new-student').slideToggle()
    $('#new-student-link').show()

  $('#delete-student-link').on 'click', (e)->
    e.preventDefault()
    $('#delete-modal').modal('show')

  $("#upload-student-picture-link").click ->
    $("#upload-student-picture").toggle()
    
  $('.datepicker').datepicker(format:'yyyy/mm/dd')
  $(".class-group-select").combobox()

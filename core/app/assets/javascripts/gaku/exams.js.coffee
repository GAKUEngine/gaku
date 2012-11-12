# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->  
  $(document).on 'click','#exam_use_weighting', ->
    if $(@).is ':checked' 
      $('#exam_weight').attr 'class','validate[required, custom[integer]min[0]] span12'
    else
      $('#exam_weight').attr 'class','span12'
      $('.exam_weightformError').remove()

  
  $('#new-exam-exam-portion-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-exam-exam-portion').slideToggle()

  $('#cancel-exam-exam-portion-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-exam-exam-portion').slideToggle()


  # cancel new exam form
  $('#new-exam').on 'click','#cancel-exam-link', (event)->
    event.preventDefault()
    $('#new-exam').slideToggle()
    $('#new-exam-link').show()



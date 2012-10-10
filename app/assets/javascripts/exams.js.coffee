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

  
	$('#add_exam_exam_portion').on 'click','a.btn', (event) ->
		event.preventDefault()
		$('#exam_exam_portions_form').slideToggle()



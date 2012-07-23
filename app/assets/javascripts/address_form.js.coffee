# Dynamic change states based on country
$ ->
	stateDropdown = $('#state_dropdown')
	$('#country_dropdown').on 'change', (e) ->
		countryCode = $("#country_dropdown option:selected").val()
		$.ajax
			type: 'get'
			url: '/states'
			data:
				country_id: countryCode
			dataType: 'json'
			success: (data)->
				stateLabel = $('.state_label')
				stateDropdownName = stateDropdown.attr('name')
				stateInput = $('<input type="text" class="span12 state_input" name="' + stateDropdownName + '"> ')
				if $.isEmptyObject(data) 
					$('.state_input').remove()
					stateDropdown.remove()
					stateLabel.after stateInput
				else
					$('.state_input').remove()
					stateLabel.after stateDropdown
					$.each data, (i, data) ->
						stateDropdown.append('<option value="' + data.name + '">' + data.name + '</option>')




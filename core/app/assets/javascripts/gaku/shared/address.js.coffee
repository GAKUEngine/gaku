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
				stateSelect = $('<select class="span12 state_select" name="' + stateDropdownName + '"> ')


				if $.isEmptyObject(data) 
					$('.state_select').remove()
					stateDropdown.attr('value', state_preset)
					stateLabel.after stateDropdown
				else
					stateDropdown.remove()
					$('.state_select').remove()
					stateLabel.after stateSelect
					$.each data, (i, data) ->
						if state_preset == data.state.name
							stateSelect.append('<option selected="selected" value="' + data.state.name + '">' + data.state.name + '</option>')
						else
							stateSelect.append('<option value="' + data.state.name + '">' + data.state.name + '</option>')
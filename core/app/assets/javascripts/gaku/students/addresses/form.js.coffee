# Dynamic change states based on country
$ ->
	$('body').on 'change','#country_dropdown', (e) ->
		countryCode = $("#country_dropdown option:selected").val()
		$.ajax
			type: 'get'
			url: '/states'
			data:
				country_id: countryCode
			dataType: 'json'
			success: (data)->
				stateDropdown = $('#state_dropdown')
				stateLabel = $("label[for='address_state_name']")
				stateDropdownName = stateDropdown.attr('name')
				stateSelect = $('<select class="span12 state_select" name="' + stateDropdownName + '"> ')


				if $.isEmptyObject(data) 
					$('.state_select').remove()
					# stateLabel.after stateDropdown
					stateDropdown.show()
					stateDropdown.prop('disabled', false)
				else
					stateDropdown.hide()
					stateDropdown.prop('disabled', true)
					$('.state_select').remove()
					stateLabel.after stateSelect
					$.each data, (i, data) ->
						stateSelect.append('<option value="' + data.state.name + '">' + data.state.name + '</option>')
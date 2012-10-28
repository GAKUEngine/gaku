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
				
				console.log(data)
				console.log($.isEmptyObject(data))

				if $.isEmptyObject(data) 
					$('.state_select').remove()
					stateLabel.after stateDropdown
				else
					stateDropdown.remove()
					$('.state_select').remove()
					stateLabel.after stateSelect
					$.each data, (i, data) ->
						stateSelect.append('<option value="' + data.name + '">' + data.name + '</option>')
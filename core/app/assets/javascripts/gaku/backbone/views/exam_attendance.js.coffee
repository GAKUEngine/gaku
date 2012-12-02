class GAKUEngine.Views.ExamAttendance extends Backbone.View
	template: JST['gaku/backbone/templates/attendance_chooser']
	
	events:
		'submit #grading-attendance-type-select' : 'createAttendance'

	render: ->
		$(@el).html @template({attendanceTypes: @options.attendance_types.toJSON(), attendanceUrl : @options.attendanceUrl})
		$('body').delegate '#grading-attendance-type-select', 'submit', (event)=>
			event.preventDefault()
			@createAttendance(event)
		@

	createAttendance: (event)->
		event.preventDefault()
		form = $(event.currentTarget)
		attendanceUrl = form.attr('action')
		attendanceTypeId = form.children('select').attr('value')
		attendanceReason = form.children('input').attr('value')


		attendance = new GAKUEngine.Models.Attendance()
		attendance.url = attendanceUrl
		attendance.bind 'change', @afterCreate
			

		attendance.set('attendance': {'reason': attendanceReason ,'attendance_type_id': attendanceTypeId})

		attendance.save {}, success: (response)=>
			@options.currentTarget.attr('data-attendance', response.id)
			@options.currentTarget.closest('.score-column')
												 .find('input').attr('disabled', '')
			
			@options.currentTarget.popover('destroy')	

	

   
    

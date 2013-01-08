class GAKUEngine.Views.ExamAttendance extends Backbone.View
	template: JST['gaku/backbone/templates/attendance_chooser']

	# events:
	# 	'submit #grading-attendance-type-select' : 'alertMe'

	render: ->
		that = @
		@submitId = "#" + @options.examPortionScore + "-submit"
		$(@el).empty().html @template({ attendanceTypes: @options.attendance_types.toJSON(), attendanceUrl : @options.attendanceUrl,examPortionScore: @options.examPortionScore, attendance: @options.attendance.toJSON() if @options.attendance })

		$('body').undelegate @submitId, 'submit'

		$('body').delegate @submitId, 'submit', (event)=>
			event.preventDefault()
			@createAttendance(event)

		$('body').undelegate '.delete-attendance', 'click'

		$('body').delegate '.delete-attendance', 'click', (event) ->
			event.preventDefault()

			attendanceInpit =  $('#score-' + that.options.attendance.get('attendancable_id'))
			attendanceInpit.removeAttr("disabled")
			attendanceInpit.closest('td').children('.portion_set_attendance').removeAttr('data-attendance')

			that.options.attendance.destroy()
			that.options.currentTarget.popover('destroy')
		@

	createAttendance: (event)->
		event.preventDefault()
		form = $(event.currentTarget)
		attendanceUrl = form.attr('action')
		attendanceTypeId = form.children('select').attr('value')
		attendanceReason = form.children('input').attr('value')


		attendance = new GAKUEngine.Models.Attendance()
		attendance.url = attendanceUrl
		attendance.set('attendance': {'reason': attendanceReason ,'attendance_type_id': attendanceTypeId})

		attendance.save {}, success: (response)=>
			@options.currentTarget.attr('data-attendance', response.id)
			@options.currentTarget.closest('.score-column')
												 .find('input').attr('disabled', '')

			@options.currentTarget.popover('destroy')
			$('body').undelegate @submitId, 'submit'




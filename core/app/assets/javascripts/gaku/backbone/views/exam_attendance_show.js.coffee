class GAKUEngine.Views.ExamAttendanceShow extends Backbone.View
	template: JST['gaku/backbone/templates/tables/attendance_show']

	render: ->
		$(@el).html @template(attendance: @model.toJSON())
		@
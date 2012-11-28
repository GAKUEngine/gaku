class GAKUEngine.Views.ExamAttendance extends Backbone.View
	template: JST['gaku/backbone/templates/attendance_chooser']

	initialize: ->

	render: ->
    @options = {}
    $(@el).html @template(@options)
		@

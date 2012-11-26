class GAKUEngine.Views.ExamCalculationsView extends Backbone.View
	template: JST['gaku/backbone/templates/tables/exam_calculations']

	render: ->
		$(@el).html @template(@options)
		@

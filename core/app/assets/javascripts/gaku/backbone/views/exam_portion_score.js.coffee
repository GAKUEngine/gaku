class GAKUEngine.Views.ExamPortionScore extends Backbone.View
	template: JST['gaku/backbone/templates/tables/exam_calculations']

	initialize: ->

	render: ->
		$(@el).html @template(@options)
		@

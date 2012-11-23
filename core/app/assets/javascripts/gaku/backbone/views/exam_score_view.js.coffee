class GAKUEngine.Views.ExamScoreView extends Backbone.View

	template: JST['gaku/backbone/templates/tables/exam_score']

	render: ->
		$(@el).html @template(@options)
		@

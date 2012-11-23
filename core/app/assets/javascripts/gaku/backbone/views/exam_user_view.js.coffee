class GAKUEngine.Views.ExamUserView extends Backbone.View

	template: JST['gaku/backbone/templates/tables/exam_user']

	render: ->
		$(@el).html @template(@options)
		@


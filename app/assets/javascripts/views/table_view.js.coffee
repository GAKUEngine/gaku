class GAKUEngine.Views.TableView extends Backbone.View
	template: JST['table/table']

	initialize: ->

	render: ->
		$(this.el).html @template(course: @options.course.toJSON(), exams: @options.exams.toJSON())
		@

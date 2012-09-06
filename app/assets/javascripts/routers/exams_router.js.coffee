class GAKUEngine.Routers.ExamsRouter extends Backbone.Router
	
	initialize: (options)->
		@exams = new GAKUEngine.Collections.Exams options.exams
		@course = new GAKUEngine.Models.Course options.course

	routes:
		'': 'index'

	index: ->
		@tableView = new GAKUEngine.Views.TableView course: @course, exams: @exams
		console.log @tableView.render().el
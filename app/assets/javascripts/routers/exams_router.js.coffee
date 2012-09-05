class GAKUEngine.Routers.ExamsRouter extends Backbone.Router
	
	initialize: (options)->
		console.log options.exams
		@exams = new GAKUEngine.Collections.Exams()
		@exams.reset options.exams
		console.log @exams


	routes:
		'': 'index'

	index: ->
		console.log 'index routes called'
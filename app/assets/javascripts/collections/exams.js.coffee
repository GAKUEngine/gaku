class GAKUEngine.Collections.Exams extends Backbone.Collection
	model: GAKUEngine.Models.Exam
	url: ->
		"http://localhost:3000/exams/"




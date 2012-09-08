class GAKUEngine.Models.Exam extends Backbone.Model

	url: ->
		url = window.location.href.split('/')
		course_id = url[4]		
		exam_id = url[6]
		return "http://localhost:3000/courses/#{course_id}/exams/#{exam_id}"

	initialize: ->
		@fetch
	
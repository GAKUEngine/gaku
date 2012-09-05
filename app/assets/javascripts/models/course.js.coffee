class GAKUEngine.Models.Course extends Backbone.Model
	url: ->
		url = window.location.href.split('/')
		course_id = url[4]
		return "http://localhost:3000/courses/#{course_id}"		

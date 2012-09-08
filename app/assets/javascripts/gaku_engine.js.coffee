window.GAKUEngine =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
  	window.exam = new GAKUEngine.Models.Exam()
  	window.exam.fetch()
  	window.course = new GAKUEngine.Models.Course()
  	window.course.fetch()
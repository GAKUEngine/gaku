class GAKUEngine.Views.TableView extends Backbone.View
	template: JST['table/table']

	events:
		'submit .portion_score_update': 'updatePortion'

	render: ->		
		$(this.el).html @template(course: @options.course.toJSON(), exams: @options.exams.toJSON())
		@

	updatePortion: (event)->
		event.preventDefault()
		@exam_score = new GAKUEngine.Models.ExamPortionScore 
												urlLink: event.target.action
												score: event.currentTarget[0].value
		
		
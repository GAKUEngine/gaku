class GAKUEngine.Views.TableView extends Backbone.View
	template: JST['table/table']

	events:
		'submit .portion_score_update': 'updatePortion'

	render: ->		
		$(this.el).html @template(course: @options.course, exams: @options.exams, student_total_scores: @options.student_total_scores, avarage_scores: @options.avarage_scores, deviation: @options.deviation)
		@

	updatePortion: (event)->
		event.preventDefault()
		@exam_score = new GAKUEngine.Models.ExamPortionScore 
												urlLink: event.target.action
												score: event.currentTarget[0].value
												baseURI: event.target.baseURI
		
class GAKUEngine.Models.Calculation extends Backbone.Model

	initialize: ->
		@on 'change', @reRenderTableView, @

	reRenderTableView: ->

		tableView = new GAKUEngine.Views.TableView
												course: @get('course')
												exams: @get('exams')
												student_total_scores: @get('student_total_scores')
												exam_averages: @get('exam_averages')
												deviation: @get('deviation')
												students: $.parseJSON(@get('students'))

		$('.grading-container').html tableView.render().el

class GAKUEngine.Models.Calculation extends Backbone.Model

	initialize: ->
		@on 'change', @reRenderTableView, @

	reRenderTableView: ->

		tableView = new GAKUEngine.Views.TableView 
												course: @get('course')
												exams: @get('exams')
												student_total_scores: @get('student_total_scores')
												avarage_scores: @get('avarage_scores')
												deviation: @get('deviation')
#
		
		$('.grading-container').html tableView.render().el		

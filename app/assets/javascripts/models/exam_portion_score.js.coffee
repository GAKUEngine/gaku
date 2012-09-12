class GAKUEngine.Models.ExamPortionScore extends Backbone.Model
	idAttribute: "score"

	initialize:(options)->
		@on 'change', @fetchCalculations, @

		@url = options.urlLink
		@fetch()
		@set({score: options.score})
		portionView = new GAKUEngine.Views.ExamPortionScore model: @
		@save()


	fetchCalculations: ->
		calculations = new GAKUEngine.Models.Calculation()
		calculations.url = options.baseURI
		calculations.fetch()

		
		# console.log calculations.get('exams')
		# course = calculations.get('course')
		# exams = calculations.get('exams')
		# student_total_scores = calculations.get('student_total_scores')
		# avarage_scores = calculations.get('avarage_scores')
		# deviation = calculations.get('deviation')  
	
		# console.log calculations.get('course')

		# @tableView = new GAKUEngine.Views.TableView 
		# 										course: course.toJSON(), 
		# 										exams: @options.exams
		# 										student_total_scores: @options.student_total_scores
		# 										avarage_scores: @options.avarage_scores
		# 										deviation: @options.deviation

		
		# $('.grading-container').html @tableView.render().el		



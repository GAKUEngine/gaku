class GAKUEngine.Views.TableView extends Backbone.View
	
	
	template: JST['table/table']

	events:
		'blur .portion_score_update': 'validatePortion'
		'click .portion_score_update input': 'removeBorder'

	render: ->		
		$(this.el).html @template(course: @options.course, exams: @options.exams, student_total_scores: @options.student_total_scores, avarage_scores: @options.avarage_scores, deviation: @options.deviation)
		@
  

	validatePortion: (event)->
		currentTarget = $(event.currentTarget)
		currentTargetInput = currentTarget.find('input')
		currentTargetValue = currentTargetInput.attr('value')

		if currentTargetValue > 100
    	currentTargetInput.addClass('score-error')
  	else if currentTargetValue < 0
    	currentTargetInput.addClass('score-error')
    else
    	@updataPortion(currentTarget.attr('action'), event.target.value, event.target.baseURI )
			
	
	updataPortion:(urlLink, score, baseURI) ->
		@exam_score = new GAKUEngine.Models.ExamPortionScore 
														urlLink: urlLink
														score: score
														baseURI: baseURI
	
	removeBorder:(event)->
		$(event.currentTarget).removeClass('score-error')

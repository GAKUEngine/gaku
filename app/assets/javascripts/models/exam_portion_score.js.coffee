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

		
		

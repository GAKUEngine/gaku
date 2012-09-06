class GAKUEngine.Models.ExamPortionScore extends Backbone.Model
	idAttribute: "score"



	initialize:(options)->
		@url = options.urlLink
		@fetch()
		@set({score: options.score})
		portionView = new GAKUEngine.Views.ExamPortionScore model: @
		@save()




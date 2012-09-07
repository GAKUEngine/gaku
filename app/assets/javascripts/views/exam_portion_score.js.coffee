class GAKUEngine.Views.ExamPortionScore extends Backbone.View
	initialize: ->
		@model.on 'change', @updateLayout, @

	updateLayout:  ->
		alert @model.get('id')
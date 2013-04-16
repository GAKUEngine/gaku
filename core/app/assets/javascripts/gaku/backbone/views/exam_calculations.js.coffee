class GAKUEngine.Views.ExamCalculationsView extends Backbone.View
	template: JST['gaku/backbone/templates/tables/exam_calculations']

	render: ->
    $(@el).html @template(@options)

    completed = $('.show-completed').attr('data-completed')

    if completed
      completed = completed.split(',')
      for id in completed
        @.$("tr.student_#{id}").hide()
        # $(@el).find("tr.student_#{id}").hide()

    @





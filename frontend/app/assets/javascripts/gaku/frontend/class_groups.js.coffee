ready = ->
	self = this

	class ClassGroupsController
		index: ->
			$(document).on 'change', "#search-class-groups select", (event) ->
				action = $("#search-class-groups ").attr('action')
				form_data = $("#search-class-groups ").serialize()
				$.get(action, form_data, null, "script")
				history.pushState(null, "", action + "?" + form_data)
				return false

		edit: ->
			self.app.student_chooser()
			$(document).on 'keyup', 'input.update-semester-attendance', ->
				$(@).parent('form').submit()

	@app.class_groups = new ClassGroupsController

$(document).ready(ready)
$(document).on('page:load', ready)

ready = ->

  self = this

  class StudentsController
    index: ->
      self.app.student_chooser()

    edit: ->
      self.app.country_dropdown()

      $(document).on 'click', '#cancel-student-commute-method-link', (e) ->
        e.preventDefault()
        $('#student-commute-method-form').slide ->
          $('#commute-method').show()
          $('#edit-student-commute-method-link').show()

      $('#delete-student-link').on 'click', (e)->
        e.preventDefault()
        $('#delete-modal').modal('show')

      $('#student-achievements-tab-link').on 'shown', (e)->
        $('.achievements-group').each (index, element) ->
          heights = []
          $(element).children('li').each (index, li)->
            heights.push $(li).height()
          maxHeight =  Math.max.apply(null,heights)

          $(element).find('li').children('.thumbnail').each (index, li)->
            $(@).height maxHeight

  @app.students = new StudentsController


$(document).ready(ready)
$(document).on('page:load', ready)

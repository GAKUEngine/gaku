ready = ->

  self = this

  class StudentsController
    index: ->
      self.app.student_chooser()

      $('body').on 'click', '.hide-chosen-table', (event) ->
        event.preventDefault()
        $('.hide-chosen-table').hide()
        $('.show-chosen-table').show()
        $('#chosen-table').slide()
        $('#chosen-actions').slide()

    edit: ->
      self.app.country_dropdown()
      self.app.upload_picture_ajax()

      students = JSON.parse(localStorage['students'])

      students.map (student) ->
        $('#students-collection').append("<li class=#{student['id']}><a href='#{students_path}/#{student['id']}'>#{student['name']}</a></li>")


      $(document).on 'click', '#cancel-student-commute-method-link', (e) ->
        e.preventDefault()
        $('#student-commute-method-form').slide ->
          $('#commute-method').show()
          $('#edit-student-commute-method-link').show()

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

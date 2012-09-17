class GAKUEngine.Routers.ExamsRouter extends Backbone.Router

  initialize: (options)->
    @options = options

  routes:
    '': 'index'

  index: ->
    @tableView = new GAKUEngine.Views.TableView
      course: @options.course
      exams: @options.exams
      student_total_scores: @options.student_total_scores
      exam_averages: @options.exam_averages
      deviation: @options.deviation
      students: @options.students

    $('.grading-container').html @tableView.render().el

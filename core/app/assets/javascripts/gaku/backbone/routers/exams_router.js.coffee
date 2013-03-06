class GAKUEngine.Routers.ExamsRouter extends Backbone.Router

  initialize: (options)->
    @options = options

  routes:
    '': 'index'

  index: ->
    @tableView = new GAKUEngine.Views.ExamTableView
      course: @options.course
      exams: @options.exams
      student_total_scores: @options.student_total_scores
      exam_averages: @options.exam_averages
      deviation: @options.deviation
      students: @options.students
      grades: @options.grades
      ranks: @options.ranks
      attendances: @options.attendances
      path_to_exam: @options.path_to_exam
      completion: @options.completion
    $('.grading-container').html @tableView.render().el
